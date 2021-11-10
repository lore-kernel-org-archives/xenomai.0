Subject: Re: Trying Xenomai3.2 and has some web browser problem
References: <TY2PR04MB3838919175C4210652E4FCD4AA939@TY2PR04MB3838.apcprd04.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ae935e63-ad36-7d98-da3a-7046948ab38a@siemens.com>
Date: Wed, 10 Nov 2021 12:15:39 +0100
MIME-Version: 1.0
In-Reply-To: <TY2PR04MB3838919175C4210652E4FCD4AA939@TY2PR04MB3838.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ando Yuta <andouyuuta@yamaha-motor.co.jp>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.11.21 07:33, Ando Yuta via Xenomai wrote:
> Hello
> 
> We are now testing xenomai3.2 with dovetail core(kernel ver5.10.70)

x86?

> The kernel build was successful with some modifications to the ipipe configuration we had been using.
> Building our application was also successful without any problems, just by slightly changing the flags in cmake.
> So our application is working well, except for one thing.
> 
> When using xenomai 3.1 with ipipe patch 5.4.77, there was no problem,
> but when using 5.10.70 dovetail, the web browser started to crash.
> 
> Firefox didn't work at all.
> When using Google Chrome and chromium, some pages don't crash and some,
> in particular, video sites like youtube and sites that require login such as github did.
> 
> Attached below are the results of strace when using chrome.
> The problem seems to be around seccomp.
> 
> If we follow this web(https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/linux/sandboxing.md)
> and specify --disable-seccomp-filter-sandbox, the crash was apparently avoided.
> However, this option disables sandbox, which causes a security problem.
> Therefore, we do not want to disable sandbox if possible.
> 
> This browser crash does not occur on the same 5.10.70 kernel unless we enable the dovetail realtime kernel, so
> It seems to be an issue with a system call related to dovetail's seccomp.
> Is there any way to solve this problem?
> 
> The strace results are as follows
> 

Can you generate a trace (strace or maybe even kernel event trace) of
both good an bad cases? To see where the behaviour diverges.

Or is there something that reproduces this without requiring a full UI
for the browser?

Thanks for reporting!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

