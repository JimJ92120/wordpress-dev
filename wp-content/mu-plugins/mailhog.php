<?php
/**
 * Plugin Name: Mailhog SMTP Server
 * Description: Connect to Mailhog SMTP Server via Docker containers.
 * 
 * @package Mailhog
 */

add_action(
    'wp_mail_failed',
    function ( $wp_error ) {
        write_log( $wp_error );
    },
    10,
    1
);

add_action(
    'phpmailer_init',
    function ( $phpmailer ) {
        $phpmailer->isSMTP();

        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->SMTPAuth = false;
        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->SMTPSecure = '';
        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->SMTPAutoTLS = false;

        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->Host = SMTP_HOST;
        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->Port = SMTP_PORT;
        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->From = SMTP_FROM;
        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->FromName = SMTP_FROM_NAME;
        // phpcs:ignore WordPress.NamingConventions.ValidVariableName.UsedPropertyNotSnakeCase
        $phpmailer->SMTPDebug = SMTP_DEBUG;
    }
);

add_filter(
    'wp_mail_from',
    function () {
        return SMTP_FROM;
    },
    10,
    1
);

add_filter(
    'wp_mail_from_name',
    function () {
        return SMTP_FROM_NAME;
    },
    10,
    1
);
