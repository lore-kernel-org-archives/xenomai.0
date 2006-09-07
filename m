Message-ID: <45007982.2000503@domain.hid>
Date: Thu, 07 Sep 2006 14:56:50 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Porting / API Questions
References: <44FF3C26.10501@domain.hid> <44FFF5FF.2000106@domain.hid>
In-Reply-To: <44FFF5FF.2000106@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
>> In this simulation, we use the rtlinux POSIX-like API for threads,
>> timing, and writing-to / reading-from real-time FIFOs.  It looks like
>> the xeno_posix API will allow me to port the thread and timing code with
>> very few (if any) changes.  There does not appear to be a kernel-space
>> version of read and write for use on xenomai pipes.  Am I missing
>> something?
> 
> For what side, RT or non-RT? Or what service (function name) is missing
> precisely?

RT-Linux has a mostly POSIX interface to rt-fifos.  You must create/delete them using the non-standard rtf_create/rtf_destroy, but after that, you can open, close, read, and write them using a file descriptor.  I was wondering if this mapping exists for the real-time Xenomai POSIX API.  I am specifically asking about kernel-space right now, but I would also like to know if this sort of thing is supported from user-space real-time as well.

-Jeff


