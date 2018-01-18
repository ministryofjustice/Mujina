package mujina.api;

import lombok.Getter;
import lombok.Setter;
import mujina.idp.user.SamlUser;
import mujina.idp.user.SamlUserStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.saml.key.JKSKeyManager;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.function.Predicate;

import static java.util.Arrays.asList;
import static java.util.Collections.singletonList;
import static java.util.Collections.unmodifiableList;

@Getter
@Setter
@Component
public class IdpConfiguration extends SharedConfiguration {

  private static final String ROLE_USER = "ROLE_USER";
  private static final String ROLE_ADMIN = "ROLE_ADMIN";
  private static final List<SimpleGrantedAuthority> ADMIN_ROLES = unmodifiableList(asList(new SimpleGrantedAuthority(ROLE_USER), new SimpleGrantedAuthority(ROLE_ADMIN)));
  private static final List<SimpleGrantedAuthority> USER_ROLES = unmodifiableList(singletonList(new SimpleGrantedAuthority(ROLE_USER)));

  private String defaultEntityId;
  private Map<String, List<String>> attributes = new TreeMap<>();
  private List<UsernamePasswordAuthenticationToken> users = new ArrayList<>();
  private String acsEndpoint;
  private AuthenticationMethod authenticationMethod;
  private AuthenticationMethod defaultAuthenticationMethod;
  private final String idpPrivateKey;
  private final String idpCertificate;
  private final SamlUserStore samlUserStore;

  @Autowired
  public IdpConfiguration(JKSKeyManager keyManager,
                          @Value("${idp.entity_id}") String defaultEntityId,
                          @Value("${idp.private_key}") String idpPrivateKey,
                          @Value("${idp.certificate}") String idpCertificate,
                          @Value("${idp.auth_method}") String authMethod,
                          SamlUserStore samlUserStore) {
    super(keyManager);
    this.defaultEntityId = defaultEntityId;
    this.idpPrivateKey = idpPrivateKey;
    this.idpCertificate = idpCertificate;
    this.defaultAuthenticationMethod = AuthenticationMethod.valueOf(authMethod);
    this.samlUserStore = samlUserStore;
    reset();
  }

  @Override
  public void reset() {
    setEntityId(defaultEntityId);
    resetAttributes();
    resetKeyStore(defaultEntityId, idpPrivateKey, idpCertificate);
    resetUsers();
    setAcsEndpoint(null);
    setAuthenticationMethod(this.defaultAuthenticationMethod);
    setSignatureAlgorithm(getDefaultSignatureAlgorithm());
  }

  private void resetUsers() {
    users.clear();
    users.add(createUser("admin", "secret", ADMIN_ROLES));
    users.add(createUser("user", "secret", USER_ROLES));
    addSamlUsers();
  }

  private UsernamePasswordAuthenticationToken createUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
    return new UsernamePasswordAuthenticationToken(username, password, authorities);
  }

  private void addSamlUsers() {
    Predicate<SamlUser> defaultUserFilter =
      samlUser -> users.stream()
        .noneMatch(token -> token.getPrincipal().equals(samlUser.getUsername()));

    samlUserStore.getSamlUsers().stream()
      .filter(defaultUserFilter)
      .forEach(samlUser -> users.add(createUserFromSaml(samlUser)));
  }

  private UsernamePasswordAuthenticationToken createUserFromSaml(SamlUser samlUser) {
    return createUser(samlUser.getUsername(), samlUser.getPassword(), USER_ROLES);
  }

  private void resetAttributes() {
    attributes.clear();
  }

  public void putAttribute(String key, String... values) {
    this.attributes.put(key, asList(values));
  }

}
