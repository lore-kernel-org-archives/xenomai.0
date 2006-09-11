Message-ID: <4505E719.3030405@domain.hid>
Date: Mon, 11 Sep 2006 17:45:45 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] read returns more bytes than requested?
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

I am having some success porting my RTLinux application, but I have encountered a strange error.

I have this snippet of code that is reading data from an rtai-skin FIFO:

  result = read(runtime2io_fd, &resp, sizeof(resp));
  if (result != sizeof(resp))
    {
      printf("requested %d bytes, got %d\n", sizeof(resp), result);
      snprintf(err_str, MAX_STR_LEN, "cannot read response from %s",
               RUNTIME2IO_FIFO_DEV);
      sim_halt(err_str);
      return;
    }

I get the following output:

  requested 312 bytes, got 1220
  halting the sim: cannot read response from /dev/rtf1

I didn't think that a read could return more bytes than was requested.  Does anyone understand this behaviour?  This is code that works under RT-Linux.  I am trying to determine why it is working differently under xenomai.

-Jeff

