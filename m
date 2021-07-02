Subject: Re: Task running on cobalt or gpos kernel
References: <CAB9YM8hBb80os9yozK1QWBLtQvG63LeSL8LMVVeGwPFk0_znjQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a84bb143-e541-8a0b-13c5-08ee420a600a@siemens.com>
Date: Fri, 2 Jul 2021 08:21:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAB9YM8hBb80os9yozK1QWBLtQvG63LeSL8LMVVeGwPFk0_znjQ@mail.gmail.com>
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
To: Rui Queiroz <rqueiroz@dei.uc.pt>, xenomai@xenomai.org

On 01.07.21 16:01, Rui Queiroz via Xenomai wrote:
> Hello,
> 
> Can someone enlighten me on whether there is some sort of command that
> allows:
> - checking if there are processes being scheduled by the cobalt scheduler
> and list them;
> - checking to see if a particular process being scheduled by cobalt RT
> scheduler or if by the linux general purpose scheduler?
> 

Have a look at the files under /proc/xenomai/sched/, specifically
'threads', and also check the thread flags as described in [1].

Jan

[1]
https://source.denx.de/Xenomai/xenomai/-/blob/master/include/cobalt/uapi/kernel/thread.h#L87

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

