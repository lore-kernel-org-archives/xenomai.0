References: <CAPOa_Z=cG=zxVy7sjng+GRfgZtiaFvDvW9sTBmKLczbVBpGqtw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56D31712.7020609@xenomai.org>
Date: Sun, 28 Feb 2016 16:49:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAPOa_Z=cG=zxVy7sjng+GRfgZtiaFvDvW9sTBmKLczbVBpGqtw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] a Bug fixup for vendors/raspberry/ipipe-4.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?6Z+p5bu65qGl?= <hanjianqiao@gmail.com>, xenomai@xenomai.org

On 02/28/2016 12:19 PM, 韩建桥 wrote:
> Hi!
> 
> When a GPIO interrupt (a simple example as gpio_int.tar.gz shows) occurs
> the kernel crashing down is due to irq_get_handler_data always returns NULL.
> commit: b8567a9d0a5a97b53423f305e77369f2010d54fd
> 
> Fixup is the attachment: raspberry-ipipe-4.1-patch
> 
> 
> 

Merged, thanks.


-- 
Philippe.

