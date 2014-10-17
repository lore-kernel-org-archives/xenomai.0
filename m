Message-ID: <5440D754.3070104@xenomai.org>
Date: Fri, 17 Oct 2014 10:46:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+s4EgOPFWWfCUSJuzLMRyChoN7YeV+C2m_cJjwT3UFC4D-G5Q@mail.gmail.com>
 <CA+s4EgOS8U5XMkRi7YwE1S81s5zEGf6yuem1DnU0i2bFBZQ6Qg@mail.gmail.com>
 <CA+s4EgO8FMecuGx7=8UbPm0Tx0eLMKQV0W6fOW_z91X_abKkpA@mail.gmail.com>
In-Reply-To: <CA+s4EgO8FMecuGx7=8UbPm0Tx0eLMKQV0W6fOW_z91X_abKkpA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Fwd: xenomai patch for cubieboard2 with Allwinner
 A20(sun7i) board (Kernel : v3.4.79)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nagarjun R <nagarjunrajen@gmail.com>, xenomai@xenomai.org

On 10/17/2014 09:59 AM, Nagarjun R wrote:
> Hi,
> 
> Greetings for the day!
> 
> I am a firmware engineer in 3D printing industry and trying to patch up the
> kernel v3.4.79(sun7i) in cubieborad2 with xenomai for getting hard real
> time tasks. But I am facing lot of difficulties in patching up. Recently I
> came across the post on a website(
> http://www.xenomai.org/pipermail/xenomai/2014-February/030164.html), which
> describes exactly the same problem,

Actually, this post does not describe the problem, but replies to
someone who has the problem. The Xenomai mailing list follows the usual
conventions where quoted lines are prefixed with "> ". So, lines
prefixed with "> " are citations, lines prefixed with "> > " are
citations of citations. Etc...

>  which is what I am facing today. I have
> tried various kernel versions with various ipipe patches. For Eg: I tried
> Mainline Kernel v3.14.16 with ipipe-core-3.14.17-arm-4.patch, it patched up
> successfully, but that kernel is not supported by Allwinner A20(sun7i)
> cubieboard2 yet and moreover while trying to compile the kernel to create
> uImage, I got the following errors:
> /home/nagarjun/linux-sunxi/linux-3.14.16/arch/arm/kernel/smp.c: In function
> ‘ipi_timer’:
> /home/nagarjun/linux-sunxi/linux-3.14.16/arch/arm/kernel/smp.c:531:2:
> warning: implicit declaration of function ‘__ipipe_mach_update_tsc’
> [-Wimplicit-function-declaration]
>   __ipipe_mach_update_tsc();

That is because the processor for which you compile has no Xenomai
support, hence the URL at the end of the messages you found.

> 
>  It would be a great help for me, if you guys have idea *whether any
> xenomai patch is available for cubieboard2 with kernel v3.4.79(sun7i)? *

Read the mail again, or the complete thread if you do not understand the
mail alone. It contains the answer to this question.

-- 
                                                                Gilles.

