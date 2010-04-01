Message-ID: <4BB5161D.5010701@domain.hid>
Date: Thu, 01 Apr 2010 23:54:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid>
	<4B9AD0DE.4020103@domain.hid>	<1268472523.27899.135.camel@domain.hid>	<4B9BB9B1.5050003@domain.hid>	<1268498034.27899.167.camel@domain.hid>	<4B9C2100.6090806@domain.hid>
	<1268584465.27899.197.camel@domain.hid>
	<4BB4F857.5020906@domain.hid> <4BB51529.9030404@domain.hid>
In-Reply-To: <4BB51529.9030404@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
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
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> ...
>> Argh.... The switchtest driver is relying on __xn_exec_current to have
>> context switches occur precisely in the mode we want. __xn_exec_adaptive
>> introduce more context switches around which we can not place separate
>> checks for fpu context, so, in short, breaks it badly. Fixing this
>> requires turning the switchtest driver into a skin with its own syscalls.
> 
> Independent of how switchtest (or RTDM) is fixed again: Do you already
> have a patch like this in your queue?
> 
> diff --git a/ksrc/drivers/testing/switchtest.c b/ksrc/drivers/testing/switchtest.c
> index 057094b..09cd0ec 100644
> --- a/ksrc/drivers/testing/switchtest.c
> +++ b/ksrc/drivers/testing/switchtest.c
> @@ -665,6 +665,9 @@ static int rtswitch_ioctl_rt(struct rtdm_dev_context *context,
>  	struct rttst_swtest_dir fromto;
>  
>  	switch (request) {
> +	case RTTST_RTIOC_SWTEST_SET_TASKS_COUNT:
> +	case RTTST_RTIOC_SWTEST_SET_CPU:
> +	case RTTST_RTIOC_SWTEST_SET_PAUSE:
>  	case RTTST_RTIOC_SWTEST_REGISTER_UTASK:
>  	case RTTST_RTIOC_SWTEST_CREATE_KTASK:
>  	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
> 
> I.e. add the missing reflections of NRT IOCTLs.

Yes, I had this fix in my tree. But switchtest is broken not only for
this reason. I am just waiting what will be decided with regard to the
two mode switches when calling an nrt ioctl from a shadowed thread
running in secondary mode, to implement a complete fix (most probably
rewriting it as a skin).

-- 
					    Gilles.

