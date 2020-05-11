Subject: Re: Could std::atomic<T> be shared bettween rt thread and nrt thread?
References: <CAAvDm6Yoj5ex9C49EfyRMBryBCsE78N_wjsS+2y2h4t_mMN33g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5a05522a-edb9-4f1d-6973-eb72c31a9dc1@siemens.com>
Date: Mon, 11 May 2020 08:40:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Yoj5ex9C49EfyRMBryBCsE78N_wjsS+2y2h4t_mMN33g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 09.05.20 10:28, 孙世龙 via Xenomai wrote:
> Hi,
>       Could std::atomic<T> be shared bettween rt thread and nrt thread?
>       Is it cause latency problem?
>       Is it cause rt thread to switch to secondary mode?
> 

I'm not familiar with their implementation details. As long as they use 
architectural atomic instructions and no syscalls, this is safe.

The problem with runtime libraries - and that also applies to C++ - is 
that you need to know their internals in order to use them safely for 
time-critical code. It's out of scope for the Xenomai project, we only 
provide that best-effort detection mechanism (SIGDEBUG).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

