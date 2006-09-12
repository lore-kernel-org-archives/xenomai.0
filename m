Subject: Re: [Xenomai-help] read returns more bytes than requested?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4505E719.3030405@domain.hid>
References: <4505E719.3030405@domain.hid>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:18:00 +0200
Message-Id: <1158045481.4978.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Mon, 2006-09-11 at 17:45 -0500, Jeff Webb wrote:
> I am having some success porting my RTLinux application, but I have encountered a strange error.
> 
> I have this snippet of code that is reading data from an rtai-skin FIFO:
> 
>   result = read(runtime2io_fd, &resp, sizeof(resp));
>   if (result != sizeof(resp))
>     {
>       printf("requested %d bytes, got %d\n", sizeof(resp), result);
>       snprintf(err_str, MAX_STR_LEN, "cannot read response from %s",
>                RUNTIME2IO_FIFO_DEV);
>       sim_halt(err_str);
>       return;
>     }
> 
> I get the following output:
> 
>   requested 312 bytes, got 1220
>   halting the sim: cannot read response from /dev/rtf1
> 
> I didn't think that a read could return more bytes than was requested.  Does anyone understand this behaviour?

The initial patch has introduced a bug. Will fix.

>   This is code that works under RT-Linux.  I am trying to determine why it is working differently under xenomai.
> 
> -Jeff
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 
-- 
Philippe.



