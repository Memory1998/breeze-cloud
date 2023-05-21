package com.breeze.cloud.auth.authentication;

@FunctionalInterface
public interface OAuthFunction<T, W, E, R> {

    R apply(T t, W w, E e);

}
