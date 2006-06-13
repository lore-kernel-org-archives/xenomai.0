Message-ID: <3384.206.81.135.88.1150211884.squirrel@domain.hid>
In-Reply-To: <448E5A2B.9060606@domain.hid>
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
	<448E5A2B.9060606@domain.hid>
Date: Tue, 13 Jun 2006 09:18:04 -0600 (MDT)
Subject: Re: [Xenomai-help] strange periodic behavior
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Well, I'm working on a desktop but frequency scaling was enabled, so I
recompiled the kernel without frequency scaling support and the behavior
still persists.  I've run the latency program from the test suite, but I'm
not sure how I should interpret the output.  What indicators am I looking
for?
-Brandt

> Brandt Erickson wrote:
>> Hey all,
>> I've been experimenting with writing a simple timer program using the
>> native API.  Basically, each loop, it writes the current timestamp into
>> shared memory which then gets read by a slower loop and written to disk.
>> The weird thing is, the period I get seems to always be half of what
>> I've
>> commanded.  That is, if I set the frequency to 1000 Hz, the difference
>> between each timestamp is a little over 2 ms (500 Hz).  It works the
>> same
>> way for 10000 Hz and 20000 Hz.  Does anyone know what causes this or how
>> to fix it?  Thanks.
>> -Brandt
>
> [FAQ] ;)
> Is powersaving via CPU frequency scaling activated (my notebook, e.g.,
> scales by 2 in that mode)? Make sure it's not. Also compare your
> findings with the output of the latency test tool. Does it suffer too?
>
> Jan
>
>



