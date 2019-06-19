MIME-Version: 1.0
References: <CAEmXcAxUwr5vkt-t=XxDG-hn9BNb0uRVjY=WevQZGMjrO-_DyA@mail.gmail.com>
In-Reply-To: <CAEmXcAxUwr5vkt-t=XxDG-hn9BNb0uRVjY=WevQZGMjrO-_DyA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 19 Jun 2019 11:03:49 -0400
Message-ID: <CALLqZ8SNt2Z66iZG-wm=yOLFsgo68tf+FwLxxxuY-vce+quHww@mail.gmail.com>
Subject: Re: Commands for reading,
 loading and unloading drivers on BeagleBone Black?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: danwe <daniel.wenninger92@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Wed, Jun 19, 2019 at 4:18 AM danwe via Xenomai <xenomai@xenomai.org> wrote:
>
> Hello,
>
> I am using a BeagleBone Black with Xenomai and RTnet on top. As some
> real-time programs are not working it could be that the installed drivers
> on my BeagleBone Black are still the standard drivers and not the real-time
> drivers.
>
Can you explain what's not working?  What are you trying to achieve?
Quick details of what you are expecting and the actual results will
help.

> As I did not find anything on internet (only how to install drivers for
> Windows when using BeagleBone Black) I would like to ask you if anyobdy
> knows commands for BeagleBone Black to read, load and unload installed
> drivers on BBB?
>
Are you talking about RTDM drivers?  What RTDM drivers are you trying
to load?  Have you configured them when you built the kernel.

> Regards
>
> Daniel

-Greg

