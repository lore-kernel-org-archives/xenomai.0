Subject: Re: problems installing Xenomai 3.1 in Ubuntu 20.04
References: <CAB9YM8hS5tg+mK_uVs3qe8A=4NXOk-KVJq1FXrVPRG5GcFU-EQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b212b335-7aee-acd4-c809-3dafb937eb9e@siemens.com>
Date: Tue, 1 Jun 2021 11:54:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAB9YM8hS5tg+mK_uVs3qe8A=4NXOk-KVJq1FXrVPRG5GcFU-EQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Jo=c3=a3o_Costa?= <joaocostalapin@gmail.com>, xenomai@xenomai.org

On 01.06.21 10:32, João Costa via Xenomai wrote:
> Hello,
> 
> I am having serious difficulties in getting Xenomai 3.1 to run in a Ubuntu
> 20.04.2 LTS [1]
> I should be doing something wrong but I don't know what. Hopefully, someone
> can help me identify what is wrong.
> 
> I was getting an error that apparently was solved (another email thread in
> this mailing list) but after some other errors showed up. I went back to
> the beginning and tried to:
> - use kernel/ipipe version 5.4.77 (.config file in attach)

Latest release is ipipe-core-5.4.105-x86-4, including a couple of I-pipe
fixes. Don't use outdated versions.

> - use kernel/ipipe version 4.19.114  (forgot to save the .config file)
> - prepatched kernel version 5.4.77  (.config file in attach) [2]
> 
> Now I am always getting this *error message:*
> 
> make[1]: Leaving directory '/home/xxx/linux-5.4.77'
> 
> make: *** [debian/ruleset/targets/common.mk:301: debian/stamp/build/kernel]
> Error 2
> 
> 
> In the *output* sent to the *console* it is possible to identify the
> following *errors*:
> 
> - too many arguments to function  'switch_fpu_finish'
> 
> - conflicting types for ‘sys32_put_timex’  143 |
> EXPORT_SYMBOL_GPL(sys32_put_timex);
> 

Cannot reproduce with your config yet over latest ipipe-5.4 and Xenomai
3.1.1. You must be building something inconsistent.

> *In attach you my find a .pdf file with*:
> - the specifications of the machine/OS I am using
> - the sequence of commands I used (maybe I am missing something)
> - the options I chose
> - the errors
> 

Please share inline, copy&pasted from your shell (no screenshots etc.).
Makes reviewing and commenting much easier. And make sure that you
include it completely if you are unsure about the actual error messages.

In general, I would recommend starting with the basic steps, not with
generating debian packages but rather building the vanilla
I-pipe/Xenomai trees manually. Then, with a working reference for your
target OS, you can look into the packaging as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

