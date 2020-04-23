Subject: Re: Must I implement the vm_operations while rtdm_mmap_to_user
 function is to be called?
References: <CAAvDm6Z6u56WwdtCX1Uy92PY2mWpBcr7x81U3Ke6TkvjA44X9g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <58dec97b-bd68-cd77-186a-10bc33ba8771@siemens.com>
Date: Thu, 23 Apr 2020 07:39:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Z6u56WwdtCX1Uy92PY2mWpBcr7x81U3Ke6TkvjA44X9g@mail.gmail.com>
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

On 23.04.20 05:55, 孙世龙 via Xenomai wrote:
> Hi,
>        Must I implement the vm_operations while
> rtdm_mmap_to_user function is to be called?
>        Vm_operations is to be executed on the vm_area
> of the user memory range, as per the documentation,
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__util.html#ga819ed9b5bbfd95e4f833c7f70732cebd
> .
>       I wonder when the vm_operations is to be called
> and what function it supplys.When should I
> implement the vm_operations.

  * @param[in] vm_ops vm_operations to be executed on the vm_area of the
  * user memory range or NULL
                      ^^^^^^^

If you have nothing to do on map/unmap, there is no need for the ops. 
See e.g. kernel/drivers/analogy/buffer.c for as simple of work to be done.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

