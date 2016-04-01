MIME-Version: 1.0
In-Reply-To: <20160401185027.GI22286@hermes.click-hack.org>
References: <CABprWp=4Ph8wRqtXnB7AocU0MkaYax+qC0UHRkaoFt8uhnk=vg@mail.gmail.com>
 <20160401185027.GI22286@hermes.click-hack.org>
Date: Fri, 1 Apr 2016 22:09:13 +0200
Message-ID: <CABprWp=MyN1y14sAJWY3X0gSCCVLkVTH5M0QPKRrKw696a+2KA@mail.gmail.com>
From: Varun Deshpande <varun9485@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Request for support of SIOCSHWTSTAMP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles Sir,

This plan is great ! I wish Xenomai Project a great Success !

Best Regards

Varun Deshpande
Exchange Program Student,
ESIEE Paris
+33 760 349 859

Alma Mater
Electronics & Communication Engineering,
National Institute of Technology, Bhopal (INDIA)
+91 8965 080 507

On Fri, Apr 1, 2016 at 8:50 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Fri, Apr 01, 2016 at 06:17:38PM +0200, Varun Deshpande wrote:
> > Hello Folks,
> >
> > As Xenomai-RTnet has combined, it is the solution for many hard realtime
> > systems but the main feature which is missing is SIOCSHWTSTAMP.
> > As i210 supports harware timestamping, it is crucial for performance
> > analysis. But it is not supported by rt_igb driver as SIOCSHWTSTAMP
> returns
> > "OPERATION NOT SUPPORTED"
> >
> > I kindly request you guys to please incorporate this feature so that user
> > can get hardware timestamp in cmsg header by enabling SIOCSHWTSTAMP
> option
> > for rt_igb driver as many of the ptp, avb programs evaluation is done by
> > hardware timestamp only.
>
> Correct me if I am wrong, but to get meaningful hardware timestamps,
> you need the machines to be synchronized with PTP, so, there is much
> more work to get this working than just implement this ioctl. I
> think we should start small, with software timestamps, as with
> Xenomai low latencies, and the fact that determinism requires to not
> fill the hardware queues, you should have some good precision already.
>
> --
>                                             Gilles.
> https://click-hack.org
>
