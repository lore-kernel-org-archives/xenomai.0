Message-ID: <4B25029C.9020703@domain.hid>
Date: Sun, 13 Dec 2009 16:05:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <801038.31731.qm@domain.hid>
In-Reply-To: <801038.31731.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] serial com errors
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

Yigal Goldberger wrote:
> Hi Again,
> 
> I hope it's not too long and tiring ...
> But the relevant code (I think...) is the initialization stage , and the select and read loop that blocks and reads .
> 
> 
> The problem is as follows :
> I have 2 threads listening on two different serial coms . running the same code below . Using select to block and wait for bytes to be available on the port , and then reading them with the read function .
> These 2 threads are Xenomai threads with priority higher then the thread that is responsible of working on the data .
> I see that when reaceiving with BAUDRATES lower than 115200 (38400) no problem occures , and when receving on both port with BAUDRATE 115200 , I get errors in the received bytes ( which is identified by a wrong checksum ,and sometimes with a "No more room in flip buffer" printout on the console as well as errno 11 (EAGAIN) ) . When I added a 10 mili second sleep to the executing thread (the thread that uses the data )the problem seems to disappear .
> 
> 
> Below is the 2 code parts that Initialize the file descriptor of the reading thread , and the reading select - read loop :
> 


>    while (TRUE)
>    {
> 	if (thistlp->nbytes_to_read == 1)
> 	{
> 		int xxx = tcgetattr (thistlp->fd, &thistlp->ttykey);
> 	}
> 
> 	if ((nbytes = select (thistlp->fd+1, &input, NULL, NULL,pIo_timeout /*NULL*/)) < 0)

Please read select documentation, this use of select is wrong in at
least two ways:
- select return value is not a number of bytes, it is a number of file
descriptors;
- the input fdset is modified by select to indicate which file
descriptors are ready, so you must reset it to the proper value before
each call to select.

-- 
					    Gilles.

