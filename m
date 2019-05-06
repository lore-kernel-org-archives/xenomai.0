Subject: Re: Xenomai Mercury and PREEMPT_RT
References: <1823257552.1557117297954.94.KebiMail.daeyoungsong@cnu.ac.kr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4c39d8ca-3c98-4b35-6b06-2013dc80134b@xenomai.org>
Date: Mon, 6 May 2019 10:07:00 +0200
MIME-Version: 1.0
In-Reply-To: <1823257552.1557117297954.94.KebiMail.daeyoungsong@cnu.ac.kr>
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
To: =?UTF-8?B?7Iah64yA7JiB?= <daeyoungsong@cnu.ac.kr>, xenomai@xenomai.org

On 5/6/19 6:34 AM, 송대영 via Xenomai wrote:
>     [webmailreconf.public.do?24538165]
> 
>    Hello, expert.
> 
>    I have a question about Xenomai Mercury and PREEMPT_RT.
>    Following "Xenomai 3 – An Overview of the Real-Time Framework for
>    Linux", Mercury is based on PREEMPT_RT and only offers API emulation.
>    Is Mercury's latency performance better than PREEMPT_RT?

No, it merely uses what native preemption provides for.

-- 
Philippe.

