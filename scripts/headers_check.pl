#!/usr/bin/perl

use Term::ANSIColor;
use strict;
use warnings;

my $file = $ARGV[0];
open(SOURCE, $file) or die("could not open file: $file");

my %manifest = (
  "accept_tcp_connection" => "test/helper/server.hpp",
  "AF_INET" => "sys/socket.h",
  "AF_INET6" => "sys/socket.h",
  "AF_UNIX" => "sys/socket.h",
  "alloc_mem" => "private/memory.h",
  "ASSERT_THAT" => "gmock/gmock.h",
  "ASSERT_TRUE" => "gtest/gtest.h",
  "BENCHMARK" => "benchmark/benchmark.h",
  "BENCHMARK_MAIN" => "benchmark/benchmark.h",
  "BOOL" => "windows.h",
  "cache_alloc" => "private/cache.h",
  "cache_destroy" => "private/cache.h",
  "cache_free" => "private/cache.h",
  "cache_new" => "private/cache.h",
  "cap_size_t_to_int" => "private/inthelper.h",
  "CATEGORY_TREE" => "docs/examples/wel/example_events.h",
  "clear_error" => "private/error.h",
  "clock" => "time.h",
  "clock_t" => "sys/types.h",
  "CLOCKS_PER_SEC" => "time.h",
  "close" => "unistd.h",
  "close_server_socket" => "test/helper/server.hpp",
  "config_close_tcp4_target" => "private/config/wrapper.h",
  "config_close_udp4_target" => "private/config/wrapper.h",
  "config_destroy_insertion_params" => "private/config/wrapper.h",
  "config_fopen" => "private/config/wrapper.h",
  "config_gethostname" => "private/config/wrapper.h",
  "config_getpagesize" => "private/config/wrapper.h",
  "config_get_now" => "private/config/wrapper.h",
  "config_init_tcp4" => "private/config/wrapper.h",
  "config_init_udp4" => "private/config/wrapper.h",
  "config_initialize_insertion_params" => "private/config/wrapper.h",
  "config_network_free_all" => "private/config/wrapper.h",
  "config_network_target_is_open" => "private/config/wrapper.h",
  "config_open_network_target" => "private/config/wrapper.h",
  "config_open_tcp4_target" => "private/config/wrapper.h",
  "config_open_udp4_target" => "private/config/wrapper.h",
  "config_reopen_tcp4_target" => "private/config/wrapper.h",
  "config_reopen_udp4_target" => "private/config/wrapper.h",
  "config_send_entry_to_wel_target" => "private/config/wrapper.h",
  "config_sendto_network_target" => "private/config/wrapper.h",
  "config_sendto_socket_target" => "private/config/wrapper.h",
  "config_sendto_tcp4_target" => "private/config/wrapper.h",
  "config_sendto_udp4_target" => "private/config/wrapper.h",
  "config_set_entry_wel_type" => "private/config/wrapper.h",
  "config_set_tcp4_port" => "private/config/wrapper.h",
  "config_set_udp4_port" => "private/config/wrapper.h",
  "config_tcp4_is_open" => "private/config/wrapper.h",
  "config_udp4_is_open" => "private/config/wrapper.h",
  "copy_cstring" => "private/strhelper.h",
  "cstring_to_sized_string" => "private/strhelper.h",
  "destroy_buffer_target" => "private/target/buffer.h",
  "destroy_file_target" => "private/target/file.h",
  "destroy_insertion_params" => "private/config/wel_supported.h",
  "destroy_network_target" => "private/target/network.h",
  "destroy_socket_target" => "private/target/socket.h",
  "destroy_stream_target" => "private/target/stream.h",
  "destroy_target" => "private/target.h",
  "destroy_wel_target" => "private/target/wel.h",
  "DWORD" => "windows.h",
  "entry_free_all" => "private/entry.h",
  "errno" => "errno.h",
  "EVENTLOG_ERROR_TYPE" => "windows.h",
  "EVENTLOG_INFORMATION_TYPE" => "windows.h",
  "EVENTLOG_SUCCESS" => "windows.h",
  "EVENTLOG_WARNING_TYPE" => "windows.h",
  "EXIT_FAILURE" => "stdlib.h",
  "EXIT_SUCCESS" => "stdlib.h",
  "facility_is_invalid" => "private/entry.h",
  "FAIL" => "gtest/gtest.h",
  "fclose" => "stdio.h",
  "FILE" => "stdio.h",
  "fopen" => "stdio.h",
  "format_entry" => "private/formatter.h",
  "fprintf" => "stdio.h",
  "free" => "stdlib.h",
  "free_mem" => "private/memory.h",
  "freeaddrinfo" => "netdb.h", # also in ws2tcpip.h
  "fwrite" => "stdio.h",
  "get_facility" => "private/entry.h",
  "get_paged_size" => "private/memory.h",
  "get_priv_target" => "private/target.h",
  "get_prival" => "private/entry.h",
  "get_severity" => "private/entry.h",
  "getaddrinfo" => "netdb.h", # also in ws2tcpip.h
  "gethostname" => "unistd.h", # also in winsock2.h
  "getpid" => "unistd.h",
  "gmtime" => "time.h",
  "gmtime_r_get_now" => "private/config/have_gmtime_r.h",
  "HANDLE" => "windows.h",
  "HasSubstr" => "gmock/gmock.h",
  "HAVE_GMTIME_R" => "private/config.h",
  "HAVE_SYS_SOCKET_H" => "private/config.h",
  "HAVE_UNISTD_H" => "private/config.h",
  "HAVE_WINDOWS_H" => "private/config.h",
  "HAVE_WINSOCK2_H" => "private/config.h",
  "htons" => "arpa/inet.h",
  "inet_pton" => "arpa/inet.h", # also in ws2tcpip.h
  "INIT_MEMORY_COUNTER" => "test/helper/memory_counter.hpp",
  "initialize_insertion_params" => "private/config/wel_supported.h",
  "INT_MAX" => "limits.h",
  "LPCSTR" => "windows.h",
  "LOG_INFO" => "syslog.h",
  "malloc" => "stdlib.h",
  "memcpy" => "string.h",
  "memset" => "string.h",
  "MSG_SIMPLE" => "test/function/windows/events.h",
  "name_resolves" => "test/helper/resolve.hpp",
  "network_target_is_open" => "private/target/network.h",
  "new_buffer_target" => "private/target/buffer.h",
  "new_file_target" => "private/target/file.h",
  "NEW_MEMORY_COUNTER" => "test/helper/memory_counter.hpp",
  "new_network_target" => "private/target/network.h",
  "new_socket_target" => "private/target/socket.h",
  "new_stream_target" => "private/target/stream.h",
  "new_target" => "private/target.h",
  "new_wel_target" => "private/target/wel.h",
  "NULL" => "stddef.h",
  "open_tcp_server_socket" => "test/helper/server.hpp",
  "open_udp_server_socket" => "test/helper/server.hpp",
  "perror" => "stdio.h",
  "pid_t" => "sys/types.h",
  "printf" => "stdio.h",
  "PSOCKADDR" => "winsock2.h",
  "PSOCKADDR_IN" => "winsock2.h",
  "public::testing::Test" => "gtest/gtest.h",
  "raise_address_failure" => "private/error.h",
  "raise_argument_empty" => "private/error.h",
  "raise_argument_too_big" => "private/error.h",
  "raise_error" => "private/error.h",
  "raise_file_open_failure" => "private/error.h",
  "raise_file_write_failure" => "private/error.h",
  "raise_invalid_id" => "private/error.h",
  "raise_memory_allocation_failure" => "private/error.h",
  "raise_network_protocol_unsupported" => "private/error.h",
  "raise_socket_bind_failure" => "private/error.h",
  "raise_socket_connect_failure" => "private/error.h",
  "raise_socket_failure" => "private/error.h",
  "raise_socket_send_failure" => "private/error.h",
  "raise_stream_write_failure" => "private/error.h",
  "raise_target_incompatible" => "private/error.h",
  "raise_target_unsupported" => "private/error.h",
  "raise_transport_protocol_unsupported" => "private/error.h",
  "raise_wel_close_failure" => "private/error.h",
  "raise_wel_open_failure" => "private/error.h",
  "realloc" => "stdlib.h",
  "realloc_mem" => "private/memory.h",
  "recvfrom" => "sys/socket.h",
  "recv_from_handle" => "test/helper/server.hpp",
  "RegisterEventSource" => "windows.h",
  "ReportEvent" => "windows.h",
  "resize_insertion_params" => "private/config/wel_supported.h",
  "RFC_5424_FULL_DATE_BUFFER_SIZE" => "private/formatter.h",
  "RFC_5424_FULL_TIME_BUFFER_SIZE" => "private/formatter.h",
  "RFC_5424_MAX_PRI_LENGTH" => "private/formatter.h",
  "RFC_5424_MAX_TIMESTAMP_LENGTH" => "private/formatter.h",
  "RFC_5424_MAX_HOSTNAME_LENGTH" => "private/formatter.h",
  "RFC_5424_MAX_PROCID_LENGTH" => "private/formatter.h",
  "RFC_5424_REGEX_STRING" => "test/function/rfc5424.hpp",
  "RFC_5424_TIME_SECFRAC_BUFFER_SIZE" => "private/formatter.h",
  "RFC_5424_TIMESTAMP_BUFFER_SIZE" => "private/formatter.h",
  "RFC_5424_WHOLE_TIME_BUFFER_SIZE" => "private/formatter.h",
  "RUN_ALL_TESTS" => "gtest/gtest.h",
  "send_entry_to_wel_target" => "private/target/wel.h",
  "send_entry_to_unsupported_target" => "private/target.h",
  "sendto" => "sys/socket.h", # also in winsock2.h
  "sendto_buffer_target" => "private/target/buffer.h",
  "sendto_file_target" => "private/target/file.h",
  "sendto_network_target" => "private/target/network.h",
  "sendto_socket_target" => "private/target/socket.h",
  "sendto_stream_target" => "private/target/stream.h",
  "sendto_unsupported_target" => "private/target.h",
  "set_entry_wel_type" => "private/config/wel_supported.h",
  "SIG_ERR" => "signal.h",
  "SIGINT" => "signal.h",
  "signal" => "signal.h",
  "size_t" => "stddef.h",
  "snprintf" => "stdio.h",
  "SOCKET" => "winsock2.h",
  "SOCKADDR_STORAGE" => "winsock2.h",
  "socklen_t" => "sys/socket.h",
  "ssize_t" => "sys/types.h",
  "std::cout" => "iostream",
  "std::ifstream" => "fstream",
  "std::regex" => "regex",
  "stderr" => "stdio.h",
  "strbuilder_append_app_name" => "private/entry.h",
  "strbuilder_get_buffer" => "private/strbuilder.h",
  "strbuilder_free_all" => "private/strbuilder.h",
  "strftime" => "time.h",
  "strlen" => "string.h",
  "strncpy" => "string.h",
  "struct addrinfo" => "netdb.h",
  "struct buffer_target" => "private/target/buffer.h",
  "struct file_target" => "private/target/file.h",
  "struct network_target" => "private/target/network.h",
  "struct sockaddr" => "sys/socket.h",
  "struct sockaddr_un" => "sys/un.h",
  "struct socket_target" => "private/target/socket.h",
  "struct strbuilder" => "private/strbuilder.h",
  "struct stumpless_entry" => "stumpless/entry.h",
  "struct stumpless_error" => "stumpless/error.h",
  "struct stumpless_target" => "stumpless/target.h",
  "struct stumpless_version" => "stumpless/version.h",
  "struct timespec" => "time.h",
  "struct tm" => "time.h",
  "struct wel_target" => "private/target/wel.h",
  "stumpless" => "stumpless/target.h",
  "stumpless_add_entry" => "stumpless/target.h",
  "STUMPLESS_ADDRESS_FAILURE" => "stumpless/error.h",
  "STUMPLESS_ARGUMENT_EMPTY" => "stumpless/error.h",
  "STUMPLESS_ARGUMENT_TOO_BIG" => "stumpless/error.h",
  "stumpless_free_all" => "stumpless/memory.h",
  "stumpless_set_wel_insertion_string" => "stumpless/config/wel_supported.h",
  "STUMPLESS_BUFFER_TARGET" => "stumpless/target.h",
  "stumpless_close_buffer_target" => "stumpless/target/buffer.h",
  "stumpless_close_file_target" => "stumpless/target/file.h",
  "stumpless_close_network_target" => "stumpless/target/network.h",
  "stumpless_close_socket_target" => "stumpless/target/socket.h",
  "stumpless_close_stream_target" => "stumpless/target/stream.h",
  "stumpless_close_wel_target" => "stumpless/target/wel.h",
  "STUMPLESS_DEFAULT_TRANSPORT_PORT" => "stumpless/target/network.h",
  "STUMPLESS_DEFAULT_UDP_MAX_MESSAGE_SIZE" => "stumpless/target/network.h",
  "stumpless_error_id_t" => "stumpless/error.h",
  "STUMPLESS_FILE_OPEN_FAILURE" => "stumpless/error.h",
  "STUMPLESS_FILE_TARGET" => "stumpless/target.h",
  "STUMPLESS_FILE_WRITE_FAILURE" => "stumpless/error.h",
  "stumpless_get_current_target" => "stumpless/target.h",
  "stumpless_get_default_facility" => "stumpless/target.h",
  "stumpless_get_error" => "stumpless/error.h",
  "stumpless_get_error_stream" => "stumpless/error.h",
  "stumpless_get_option" => "stumpless/target.h",
  "stumpless_get_transport_port" => "stumpless/target/network.h",
  "stumpless_get_udp_max_message_size" => "stumpless/target/network.h",
  "stumpless_id_t" => "stumpless/id.h",
  "STUMPLESS_IPV4_NETWORK_PROTOCOL" => "stumpless/target/network.h",
  "STUMPLESS_MAJOR_VERSION" => "stumpless/config.h",
  "STUMPLESS_MINOR_VERSION" => "stumpless/config.h",
  "stumpless_network_protocol" => "stumpless/target/network.h",
  "STUMPLESS_NETWORK_PROTOCOL_UNSUPPORTED" => "stumpless/error.h",
  "STUMPLESS_NETWORK_TARGET" => "stumpless/target.h",
  "stumpless_new_entry" => "stumpless/entry.h",
  "stumpless_new_network_target" => "stumpless/target/network.h",
  "stumpless_new_tcp4_target" => "stumpless/target/network.h",
  "stumpless_new_tcp6_target" => "stumpless/target/network.h",
  "stumpless_new_udp4_target" => "stumpless/target/network.h",
  "stumpless_new_udp6_target" => "stumpless/target/network.h",
  "stumpless_open_buffer_target" => "stumpless/target/buffer.h",
  "stumpless_open_file_target" => "stumpless/target/file.h",
  "stumpless_open_local_wel_target" => "stumpless/target/wel.h",
  "stumpless_open_network_target" => "stumpless/target/network.h",
  "stumpless_open_remote_wel_target" => "stumpless/target/wel.h",
  "stumpless_open_socket_target" => "stumpless/target/socket.h",
  "stumpless_open_stream_target" => "stumpless/target/stream.h",
  "stumpless_open_target" => "stumpless/target.h",
  "stumpless_open_tcp4_target" => "stumpless/target/network.h",
  "stumpless_open_udp4_target" => "stumpless/target/network.h",
  "STUMPLESS_OPTION_NONE" => "stumpless/entry.h",
  "STUMPLESS_PATCH_VERSION" => "stumpless/config.h",
  "stumpless_perror" => "stumpless/error.h",
  "stumpless_set_current_target" => "stumpless/target.h",
  "stumpless_set_default_facility" => "stumpless/target.h",
  "stumpless_set_destination" => "stumpless/target/network.h",
  "stumpless_set_entry_message" => "stumpless/entry.h",
  "stumpless_set_error_stream" => "stumpless/error.h",
  "stumpless_set_free" => "stumpless/memory.h",
  "stumpless_set_malloc" => "stumpless/memory.h",
  "stumpless_set_option" => "stumpless/target.h",
  "stumpless_set_transport_port" => "stumpless/target/network.h",
  "stumpless_set_udp_max_message_size" => "stumpless/target/network.h",
  "stumpless_set_wel_insertion_param" => "stumpless/config/wel_supported.h",
  "stumpless_set_wel_insertion_string" => "stumpless/config/wel_supported.h",
  "stumpless_set_wel_type" => "stumpless/config/wel_supported.h",
  "STUMPLESS_SOCKET_CONNECT_FAILURE" => "stumpless/error.h",
  "STUMPLESS_SOCKET_FAILURE" => "stumpless/error.h",
  "STUMPLESS_SOCKET_NAME" => "stumpless/target/socket.h",
  "STUMPLESS_SOCKET_NAME_LENGTH" => "stumpless/target/socket.h",
  "STUMPLESS_SOCKET_SEND_FAILURE" => "stumpless/error.h",
  "STUMPLESS_SOCKET_TARGETS_SUPPORTED" => "stumpless/config.h",
  "STUMPLESS_SOCKET_TARGET" => "stumpless/target.h",
  "STUMPLESS_STREAM_TARGET" => "stumpless/target.h",
  "STUMPLESS_STREAM_WRITE_FAILURE" => "stumpless/error.h",
  "STUMPLESS_SYSLOG_H_COMPATIBLE" => "stumpless/config.h",
  "STUMPLESS_TARGET_INCOMPATIBLE" => "stumpless/error.h",
  "stumpless_target_is_open" => "stumpless/target.h",
  "STUMPLESS_TARGET_UNSUPPORTED" => "stumpless/error.h",
  "STUMPLESS_TCP_TRANSPORT_PROTOCOL" => "stumpless/target/network.h",
  "stumpless_transport_protocol" => "stumpless/target/network.h",
  "STUMPLESS_TRANSPORT_PROTOCOL_UNSUPPORTED" => "stumpless/error.h",
  "STUMPLESS_UDP_TRANSPORT_PROTOCOL" => "stumpless/target/network.h",
  "stumpless_unset_option" => "stumpless/target.h",
  "STUMPLESS_WINDOWS_EVENT_LOG_TARGET" => "stumpless/target.h",
  "STUMPLESS_WINDOWS_EVENT_LOG_CLOSE_FAILURE" => "stumpless/error.h",
  "STUMPLESS_WINDOWS_EVENT_LOG_OPEN_FAILURE" => "stumpless/error.h",
  "sys_socket_close_network_target" => "private/config/have_sys_socket.h",
  "sys_socket_init_network_target" => "private/config/have_sys_socket.h",
  "sys_socket_network_free_all" => "private/config/have_sys_socket.h",
  "sys_socket_open_tcp4_target" => "private/config/have_sys_socket.h",
  "sys_socket_open_tcp6_target" => "private/config/have_sys_socket.h",
  "sys_socket_open_udp4_target" => "private/config/have_sys_socket.h",
  "sys_socket_open_udp6_target" => "private/config/have_sys_socket.h",
  "sys_socket_reopen_tcp4_target" => "private/config/have_sys_socket.h",
  "sys_socket_reopen_tcp6_target" => "private/config/have_sys_socket.h",
  "sys_socket_reopen_udp4_target" => "private/config/have_sys_socket.h",
  "sys_socket_reopen_udp6_target" => "private/config/have_sys_socket.h",
  "sys_socket_sendto_tcp_target" => "private/config/have_sys_socket.h",
  "sys_socket_sendto_udp_target" => "private/config/have_sys_socket.h",
  "sys_socket_network_target_is_open" => "private/config/have_sys_socket.h",
  "syslog" => "syslog.h",
  "SYSTEMTIME" => "windows.h",
  "TestRFC5424Compliance" => "test/function/rfc5424.hpp",
  "TestUTF8Compliance" => "test/function/utf8.hpp",
  "time" => "time.h",
  "time_t" => "time.h",
  "uintptr_t" => "stdint.h",
  "unistd_gethostname" => "private/config/have_unistd.h",
  "unistd_getpagesize" => "private/config/have_unistd.h",
  "unistd_getpid" => "private/config/have_unistd.h",
  "unsupported_target_is_open" => "private/target.h",
  "windows_getpagesize" => "private/config/have_windows.h",
  "windows_getpid" => "private/config/have_windows.h",
  "winsock2_close_network_target" => "private/config/have_winsock2.h",
  "winsock2_gethostname" => "private/config/have_winsock2.h",
  "winsock2_init_network_target" => "private/config/have_winsock2.h",
  "winsock2_network_free_all" => "private/config/have_winsock2.h",
  "winsock2_open_tcp4_target" => "private/config/have_winsock2.h",
  "winsock2_open_tcp6_target" => "private/config/have_winsock2.h",
  "winsock2_open_udp4_target" => "private/config/have_winsock2.h",
  "winsock2_open_udp6_target" => "private/config/have_winsock2.h",
  "winsock2_reopen_tcp4_target" => "private/config/have_winsock2.h",
  "winsock2_reopen_tcp6_target" => "private/config/have_winsock2.h",
  "winsock2_reopen_udp4_target" => "private/config/have_winsock2.h",
  "winsock2_reopen_udp6_target" => "private/config/have_winsock2.h",
  "winsock2_sendto_tcp_target" => "private/config/have_winsock2.h",
  "winsock2_sendto_udp_target" => "private/config/have_winsock2.h",
  "winsock2_network_target_is_open" => "private/config/have_winsock2.h",
  "WORD" => "windows.h",
  "WSACleanup" => "winsock2.h"
);

my %actual_includes;
my %needed_includes;
my $skipping=0;

foreach my $line (<SOURCE>) {
  if($line =~ m/\*\//){
    $skipping = 0;
    next;
  }

  if($line =~ m/\/\*/ or $skipping){
    $skipping = 1;
    next;
  }

  if($line =~ m/#\s*include\s*["<](.*)[">]/){
    $actual_includes{$1} = 1;
  } else {
    while(my($k, $v) = each %manifest){
      if($line =~ m/\W$k\W/ or $line =~ m/^$k\W/){
        $needed_includes{$v} = $k;
      }
    }
  }
}

print STDERR color('red');

foreach my $include (keys %actual_includes){
  if(!$needed_includes{$include}){
    print STDERR "$file: unnecessary include: $include\n";
  }
}

foreach my $include (keys %needed_includes){
  if(!$actual_includes{$include}){
    my $symbol = $needed_includes{$include};
    print STDERR "$file: missing include: $include due to usage of $symbol\n";
  }
}

print STDERR color('reset');
close(SOURCE);