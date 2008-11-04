Message-ID: <491004C8.8040406@domain.hid>
Date: Tue, 04 Nov 2008 09:16:08 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <490F0C59.9060506@domain.hid> <490F0D1E.3080509@domain.hid>
In-Reply-To: <490F0D1E.3080509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using Xenomai in early boot phase.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I want to use a Xenomai task overtaking the duties of a watchdog running
>> under Linux as soon as the Xenomai layer is available during boot up. Is
>>   there a function or variable I could inspect? With 2.3.x, I called
>> rtdm_init_task() until it returned without error but with 2.4.x it
>> results in a kernel crash :-(.
>>
> 
> What is the value of CONFIG_XENO_OPT_SYS_STACKPOOLSZ?

  #
  # Nucleus options
  #
  CONFIG_XENO_OPT_PERVASIVE=y
  CONFIG_XENO_OPT_SYS_STACKPOOLSZ=32
  # CONFIG_XENO_OPT_PRIOCPL is not set
  CONFIG_XENO_OPT_PIPE=y

Wolfgang.

