Message-ID: <2ff1a98a0804230730t44382de9i813b23d235ece2e3@domain.hid>
Date: Wed, 23 Apr 2008 16:30:02 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F13@domain.hid>
	<18446.32522.986935.299094@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F15@domain.hid>
	<2ff1a98a0804230658w57d54addu438948a91faed1d6@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F17@domain.hid>
Subject: Re: [Xenomai-help] Xenomai serial port c++ code and / or
	xeno--(xenomm-0.0.1) install problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, Apr 23, 2008 at 4:25 PM, Karch, Joshua <jkarch@domain.hid> wrote:
>
>
>
>
> Hi Gilles,
>
>  From what you're saying it appears a task is necessary to read a byte in a
> loop.  That method works.  The issue is, I want to be able to issue a read
> command to get a byte on demand from the calling thread.
>
>  With the /dev/ttyS0 driver, I used to be able to read a byte after using
> select statement without polling: My old code did the following:

Using read (or rt_dev_read) does not do any more polling than using
select, it just suspends the calling thread until some bytes are ready
to be processed.

>
>  realserial *serial = new realserial();
>  serial->startup("serialportdevice",115200);
>
>  then in a pthreaded loop I request a read
>
>  int count= serial->readbyte();
>      then I access the buffer if count>0;
>  char inchar=serial->getreadbyte();
>      process inchar
>      loop again.
>
>  I split read byte and get-read byte into two parts in order to check for 1
> second time-outs for data.
>
>  Is it possible to do this using the rtser0 driver?  If I have to use a
> task,
>  can I make the task run for only one iteration of the loop, then suspend it
> to process the byte,
>  and then reactivate it againwhen another byte is needed?

I am sorry but I really do not understand your problem. There is no
real difference between calling read in a pthread and calling
rt_dev_read in a real-time thread. The things that work with
/dev/ttyS0 should work automatically with rtser0.

If that does not work, please post a full example of code.

-- 
 Gilles

