Message-ID: <5505B174.7020308@xenomai.org>
Date: Sun, 15 Mar 2015 17:21:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1V-yP_QqD1_zZM3of8o7USJirH6kytBtND-+UuuKx6Hw@mail.gmail.com>
In-Reply-To: <CAKk99t1V-yP_QqD1_zZM3of8o7USJirH6kytBtND-+UuuKx6Hw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM suport in kernel space over Mercury?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, hdaniel@iualg.pt

On 03/13/2015 07:40 PM, Helder Daniel wrote:
> I tried unsuccessfully to compile kernel modules with RTDM suport over
> Mercury.
> 
> That was before I learned that in v3.x /usr/xenomai/include is just for
> user space.
> 
> So I guess that since the kernel supporting headers are patched to the
> kernel source tree with ipipe-core patch, RTDM support for kernel space is
> only available in Cobalt.
> 
> Can you tell me if is this right?


Correct, no RTDM support over Mercury yet.

-- 
Philippe.

