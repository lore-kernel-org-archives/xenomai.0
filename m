Message-ID: <52839493.4040300@xenomai.org>
Date: Wed, 13 Nov 2013 16:02:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN0CFw203jRKLtMmb9jCQbyQnM1hmAaHr=FtonvxxcSUov8Ujw@mail.gmail.com>
In-Reply-To: <CAN0CFw203jRKLtMmb9jCQbyQnM1hmAaHr=FtonvxxcSUov8Ujw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch the kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Grant <emailgrant@gmail.com>
Cc: xenomai@xenomai.org

On 11/13/2013 02:36 PM, Grant wrote:
> Is patching the kernel necessary in order to use xenomai?

It depends on which version of Xenomai you are talking about. If you are 
talking about Xenomai stable version, then yes, you have to follow the 
installation instructions here:
http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/

Which include running the "prepare-kernel.sh" patch, which modifies the 
kernel.

If you are talking about Xenomai current development version, a.k.a. 
Xenomai forge, then it gives you the choice of running:
- on an unmodified kernel  (but you will not have real-time guarantees);
- a kernel patched with the PREEMPT_RT patch;
- a kernel modified as with the stable version.

The current state of Xenomai forge is that it is stable enough on the 
x86 and ARM architectures to run a latency test under load.

-- 
					    Gilles.

