Subject: Re: spinlock_irq...() supported in Xenomai 2.6.5 ?
References: <CA+K1mPFcJwvsSJQP_qAs0F01zPqzPtHD7fA6AqFXX71vrSyD0w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b3921461-be89-e33c-8904-4709847903ea@siemens.com>
Date: Mon, 19 Nov 2018 08:39:00 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPFcJwvsSJQP_qAs0F01zPqzPtHD7fA6AqFXX71vrSyD0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 19.11.18 07:38, C Smith via Xenomai wrote:
> I am porting an old Linux kernelspace driver to Xenomai 2.6.5 using RTDM
> API.
> I see calls to spinlock_irq_save() and spin_unlock_irqrestore() in the old
> kernel driver code, right in the middle of an interrupt handler.
> 
> Are those spinlock calls 'wrapped' by Xenomai 2.6.5 such that they work,
> and execute in Primary mode? Is calling these a bad thing to do in the
> middle of an RTDM interrupt, will it try to switch to Secondary mode ?
> 

Neither the obsolete 2.6 (don't use it anymore!) nor current Xenomai 3 can 
perform any magic here. If your driver's IRQ routine shall run in primary mode, 
you need to migrate it explicitly to the RTDM API.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

