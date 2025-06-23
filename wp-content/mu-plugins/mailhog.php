<?php
/*
 * Plugin Name: Mailhog SMTP Server
 * 
 * Description: Connect to Mailhog SMTP Server via Docker containers.
 */

// add the action
add_action( 'wp_mail_failed', function ($wp_error) {
    print_r( $wp_error, true );
    // exit;
}, 10, 1);

// configure PHPMailer to send through SMTP
add_action( 'phpmailer_init', function ($phpmailer) {
    $phpmailer->isSMTP();

    $phpmailer->SMTPAuth = false;
    $phpmailer->SMTPSecure = '';
    $phpmailer->SMTPAutoTLS = false;

    $phpmailer->Host = SMTP_HOST;
    $phpmailer->Port = SMTP_PORT;
    $phpmailer->From = SMTP_FROM;
    $phpmailer->FromName = SMTP_FROM_NAME;

    $phpmailer->SMTPDebug = SMTP_DEBUG;
});

add_filter('wp_mail_from', function () {
    return SMTP_FROM;
}, 10, 1);

add_filter('wp_mail_from_name', function() {
    return  SMTP_FROM_NAME;
}, 10, 1);
