Message-ID: <470B4688.6010808@domain.hid>
Date: Tue, 09 Oct 2007 11:14:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <515338.44993.qm@domain.hid>	<80b317760709110456k2ef95162t19d833da7c5781de@domain.hid>	<46E699C6.80609@domain.hid>	<305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>
	<18186.42065.560821.557825@domain.hid>
In-Reply-To: <18186.42065.560821.557825@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RTOS porting on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> gclement00 at gmail.com (Gregory CLEMENT) wrote:
>  > 
>  > For RTAI we have now a working systeme with have better max latency
>  > than Xenomai ( 50us instead of around 100us for Xenomai). I plan to
>  > update the patches on our site with this new version and communicate
>  > on it on RTAI list as soon as I have some free time.
> 
> A good place for discussing about these figures would have been Xenomai
> mailing list, a place where we could have answered you immediately. Are
> you sure you are not comparing Xenomai user-space scheduling latency
> with RTAI kernel-space scheduling latency ?

Me too asked Gregory for some discussion on this long ago but received
no response.

Anyway, the critical thing beyond latencies remains *maintenance*. If
someone decides to apply I-pipe on RTAI *and* doesn't forget to
contribute to the mandatory bits of the Adeos project, work actively
within that community (test new versions and report results, track down
bugs, port to new kernels releases, etc.), anyone would benefit in the
end. BTW, that would surely stimulate discussions about differing
numbers on both sides as well.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

