From: Marco Jackel <ich@domain.hid>
Date: Thu, 23 Mar 2006 13:41:03 +0100
Message-ID: <dvu50v$5pq$1@domain.hid>
References: <dvrrgc$g2a$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <dvrrgc$g2a$1@domain.hid>
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: read data from serial device
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

Another try....

Marco Jackel wrote:
> I want to read data from the serial device

to read data from a serial device I do the following:

/* config for serial device */

static const struct rtser_config ser_config = {
    0xFFFF,                     /* config_mask */
    RTSER_DEF_BAUD,          /* baud_rate */
    RTSER_ODD_PARITY ,           /* parity */
    RTSER_8_BITS ,             /* data_bits */
    RTSER_1_STOPB ,            /* stop_bits */
    RTSER_NO_HAND ,             /* handshake */
    RTSER_DEF_FIFO_DEPTH,       /* fifo_depth*/
    RTSER_DEF_TIMEOUT,          /* rx_timeout */
    RTSER_DEF_TIMEOUT,          /* tx_timeout */
    RTSER_DEF_TIMEOUT,          /* event_timeout */
    RTSER_RX_TIMESTAMP_HISTORY, /* timestamp_history */
    RTSER_EVENT_RXPEND          /* event mask */
};

/* open the serial file */

my_fd = rt_dev_open( RTSER_FILE, 0);

/* write the serial config */

ret = rt_dev_ioctl(my_fd, RTSER_RTIOC_SET_CONFIG, &ser_config);

/* read from the device */

unsigned char buf[32];
int sz;
int red = 0;
struct rtser_event rx_event;

while (1) {
  ret = rt_task_set_mode(0, T_PRIMARY, NULL);
  ret = rt_dev_ioctl(my_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );
  red = rt_dev_read(my_fd, &buf, sizeof(buf));
  printf(RTASK_PREFIX "rt_dev_read=%s\n",buf);
  printf(RTASK_PREFIX "%d / %d byte received \n",red,sz);
}


"rt_dev_read" gives negative Results. Whats wrong?


Thanks
Marco


