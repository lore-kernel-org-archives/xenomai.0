References: <CAJ2oMh+gxphHKPqo8QcJqZ5yH0LfdoEyJOsiqoRVNm5mVzrZhA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4fa097a7-96ec-608a-a16e-e70df2c639cb@xenomai.org>
Date: Sun, 5 Feb 2017 15:11:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ2oMh+gxphHKPqo8QcJqZ5yH0LfdoEyJOsiqoRVNm5mVzrZhA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Switching between cobalt & mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>, xenomai@xenomai.org

On 02/05/2017 02:49 PM, Ran Shalit wrote:
> Hello,
> 
> I am trying to evaluate  mercury and cobalt kernels from same version
> of kernel source code.
> I am using the documentation in
> https://xenomai.org/installing-xenomai-3-x/
> I am trying to see how simply it is to switch between the cores and
> test each of them.
> (without repeating the steps for each core using duplicated source folder)
> 
> 
> 1. I have applied the prepare-kernel script, can I now just add RT
> PREEMPT in order to use mercury kernel , or must I also disable all
> Xenomai configuration and build again ? Is it possible to use kernel
> which support both RT PRREMPT and Xenomai ?
> 

It is possible and has been done many times for custom kernel trees, but
then you would need an I-pipe patch merged with the RT-preempt patch for
the same target kernel. If you don't have such combo patch, then you
will most likely have to apply the RT-preempt patch to a fresh kernel
tree, without any I-pipe bits in, otherwise conflicts may appear at
source level.

> 2. I also assume that I will also need to install the correct build of
> the Xenomai library (there is a build for mercury and another one for
> cobalt).
> 

Correct.

-- 
Philippe.

