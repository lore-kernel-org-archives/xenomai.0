Message-ID: <45A68383.3070203@domain.hid>
Date: Thu, 11 Jan 2007 12:35:47 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020506000304090108060307"
Subject: [Xenomai-help] xeno_16550A and 8250.nr_uarts=0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020506000304090108060307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have been successfully using the xeno_16550A rtdm serial driver for some time.  Up until now, I have always compiled xeno_16550A as a kernel module, and then followed this procedure:

  Boot using the following kernel options:
    kernel /boot/vmlinuz-2.6.19.1xenomai2.3.0 ro root=/dev/sda1 noapic pci=routeirq
  # setserial /dev/ttyS0 uart none
  # /sbin/modprobe xeno_16550A ioaddr=0x3f8 irq=4
  # ./sertest

My serial test program works fine in the above scenario.  However, if I try to disable the linux serial support at boot time by adding "8250.nr_uarts=0" to the kernel boot options, my serial test program does not work.  There are no errors opening, configuring, or reading from the rtdm device, but no data is received from the driver.  I assume that my test program is not initializing something properly, so it works when linux initializes the serial port.  I can't seem to find what I'm doing wrong.  Any help would be appreciated.

I am running xenomai-2.3.0/linux-2.6.19.1 on AMD Athlon 64 dual core machine.  My goal is to compile xeno_16550A into the kernel so I don't have to worry about loading the module, but I need to get the "8250.nr_uarts=0" option to work first.

Thanks,

Jeff


--------------020506000304090108060307
Content-Type: text/x-csrc;
 name="sertest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sertest.c"

/* Standard includes */
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>   /* Exit status macros and atexit */
#include <signal.h>   /* POSIX signals (sigaction) */
#include <sys/mman.h> /* Memory management (mlockall) */
#include <error.h>    /* GNU error function */
#include <fcntl.h>    /* File creation modes */
#include <strings.h>  /* bzero */

/* RTDM includes */
#include <rtdm/rtserial.h>

/* Constants */
static const char * device_name = "/dev/rtser0";
#define BUFFERSIZE 500

/* Global variables */
sig_atomic_t abort_program = 0;

/* Serial port configuration */
static const struct rtser_config serial_config = {
  RTSER_SET_BAUD | RTSER_SET_PARITY | RTSER_SET_DATA_BITS |
  RTSER_SET_STOP_BITS | RTSER_SET_HANDSHAKE | RTSER_SET_TIMEOUT_RX | 
  RTSER_SET_TIMEOUT_TX |
  RTSER_SET_FIFO_DEPTH | RTSER_SET_TIMEOUT_EVENT | RTSER_SET_TIMESTAMP_HISTORY |
  RTSER_SET_EVENT_MASK,       /* config_mask */
  9600,                       /* baud_rate */
  RTSER_NO_PARITY,            /* parity */
  RTSER_8_BITS,               /* data_bits */
  RTSER_1_STOPB,              /* stop_bits */
  RTSER_NO_HAND,              /* handshake */
  0,                          /* fifo_depth*/
  RTSER_TIMEOUT_NONE,         /* rx_timeout */
  RTSER_TIMEOUT_NONE,         /* tx_timeout */
  0,                          /* event_timeout */
  0,                          /* timestamp_history */
  0                           /* event mask */
};

/* Handle POSIX signals */
void signal_handler(int sig)
{
  abort_program = 1;
}

/* Main program */
int main(void)
{
  int err;
  int fd;

  /* Disable paging for this program's memory */
  err = mlockall(MCL_CURRENT | MCL_FUTURE);
  if (err)
    error(EXIT_FAILURE, errno,
          "could not disable memory paging for this program");

  /* Install POSIX signal handlers */
  {
    struct sigaction new_action;
    int * sig_ptr;
    int signals[] = {SIGTERM, SIGQUIT, SIGHUP, SIGINT, 0};
    
    new_action.sa_handler = signal_handler;
    sigemptyset(&new_action.sa_mask);
    new_action.sa_flags = 0;

    for (sig_ptr = signals; *sig_ptr != 0; sig_ptr++)
      {
        err = sigaction(*sig_ptr, &new_action, NULL);
        if (err)
          error(EXIT_FAILURE, errno, 
                "could not install signal handler for signal %d", *sig_ptr);
      }
  }

  /* Open the serial port */
  fd = open(device_name, O_RDONLY | O_NONBLOCK);
  if (fd < 0)
    {
      error(EXIT_FAILURE, errno, 
            "could not open %s for reading", device_name);
    }

  /* Print the previous serial configuration */
  {
    struct rtser_config previous_config;
      err = ioctl(fd, RTSER_RTIOC_GET_CONFIG, &previous_config);
    if (err) {
      error(EXIT_FAILURE, errno, "error getting serial configuration for %s",
            device_name);
    }
    printf("old config:\n");
    printf("%s: 0x%x\n", "config_mask",     previous_config.config_mask      );
    printf("%s: %d\n", "baud_rate",         previous_config.baud_rate        );
    printf("%s: %d\n", "parity",            previous_config.parity           );
    printf("%s: %d\n", "data_bits",         previous_config.data_bits        );
    printf("%s: %d\n", "stop_bits",         previous_config.stop_bits        );
    printf("%s: %d\n", "handshake",         previous_config.handshake        );
    printf("%s: %d\n", "fifo_depth",        previous_config.fifo_depth       );
    printf("%s: %d\n", "rx_timeout",        previous_config.rx_timeout       );
    printf("%s: %d\n", "tx_timeout",        previous_config.tx_timeout       );
    printf("%s: %d\n", "event_timeout",     previous_config.event_timeout    );
    printf("%s: %d\n", "timestamp_history", previous_config.timestamp_history);
    printf("%s: %d\n", "event_mask",        previous_config.event_mask       );
    printf("\n");
  }

  /* Set up the desired serial configuration */
  err = ioctl(fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
  if (err) {
    error(EXIT_FAILURE, errno, "error setting serial configuration for %s",
          device_name);
  }

  /* Print the serial configuration */
  printf("config:\n");
  printf("%s: 0x%x\n", "config_mask",     serial_config.config_mask      );
  printf("%s: %d\n", "baud_rate",         serial_config.baud_rate        );
  printf("%s: %d\n", "parity",            serial_config.parity           );
  printf("%s: %d\n", "data_bits",         serial_config.data_bits        );
  printf("%s: %d\n", "stop_bits",         serial_config.stop_bits        );
  printf("%s: %d\n", "handshake",         serial_config.handshake        );
  printf("%s: %d\n", "fifo_depth",        serial_config.fifo_depth       );
  printf("%s: %d\n", "rx_timeout",        serial_config.rx_timeout       );
  printf("%s: %d\n", "tx_timeout",        serial_config.tx_timeout       );
  printf("%s: %d\n", "event_timeout",     serial_config.event_timeout    );
  printf("%s: %d\n", "timestamp_history", serial_config.timestamp_history);
  printf("%s: %d\n", "event_mask",        serial_config.event_mask       );
  printf("\n");

  /* Print what is received on the serial port */
  while(!abort_program)
    {
      char buffer[BUFFERSIZE];
      bzero(buffer, BUFFERSIZE);
      err = read(fd, buffer, 6);
      if (err > 0)
        {
          printf("%s", buffer);
          fflush(stdout);
        }
      if (err < 0 && errno != EAGAIN)
        printf("error: %d\n", errno);

      /* Sleep for 0.1 seconds */
      {
        struct timespec dt_ts;
        dt_ts.tv_sec  = 0;
        dt_ts.tv_nsec = 100000000;      
        clock_nanosleep(CLOCK_REALTIME, 0, &dt_ts, NULL);
      }
    }

  /* Close the serial port */
  close(fd);

  return 0;
}

--------------020506000304090108060307--

