Message-ID: <4FBB5AE3.1010601@gmail.com>
Date: Tue, 22 May 2012 15:22:43 +0600
From: Alexey Galakhov <agalakhov@gmail.com>
MIME-Version: 1.0
References: <CAHyVJyzrg8gAmvc3XDDrHzrpXu926pz9FSXwuDrDsSNn3qxUUw@mail.gmail.com>
In-Reply-To: <CAHyVJyzrg8gAmvc3XDDrHzrpXu926pz9FSXwuDrDsSNn3qxUUw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help : Xenomai on ODROID-PC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 22.05.2012 10:27, Mohit Jandwani wrote:
> Hey I am a noob in development.I want to install xenomai on Odroid-PC
> which is based on exynos420 and has arm architecture.Now they have a
> page which gives the instructions on how to apply it to new boards on
> arm architecture but its way out of my league.Someone please tell me
> what do I do ?(I am ready to give lots of hours to studying )Just tell
> me what to study to make sense of it.
> 

Most likely you'll have to support exynos420 timer in order to get ipipe
working. This part of Exynos is most likely very similar to the
S3C2410/S3C2440 (I haven't read Exynos datasheet but all other Samsung
CPUs are). You may use S3C2440 code for an example.

Do you have exynos420 datasheet? It may be hard to get. All Samsung
datasheets are marked "confidential" for some unknown reason...

Regards,
Alex

