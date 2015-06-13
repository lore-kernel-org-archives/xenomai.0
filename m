Message-ID: <9c648f9ec1a5abf4d783d8f3a9ada651.squirrel@sourcetrek.com>
In-Reply-To: <05AD097B-C2A0-4279-A170-79385AC005B1@gmail.com>
References: <F89CBA55-43A8-4AE5-A859-BFE111D40561@gmail.com>
 <4019d695cc8c27a13bd17adc951e3ade.squirrel@sourcetrek.com>
 <05AD097B-C2A0-4279-A170-79385AC005B1@gmail.com>
Date: Sat, 13 Jun 2015 09:19:11 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTDM-native mainlining - status?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>


Michael Haberler wrote:
> I hope I do not overlook some boundary condition - but assuming that
> building out-of-tree RTDM support is significantly less invasive and
> version-dependent than patching a kernel, that scheme could enormously
> widen the range of platforms we could deploy with good results, and at the
> same time lower maintenance requirements.

No, alas a Linux driver is always version-dependent, so, the driver would
contain some wrappers to handle differences between version. But this is
not something new, everybody maintaining out-of-tree Linux kernel code has
been doing it for a very long time. We do it for Xenomai, even Linux
developers are doing it for the driver backport project.

-- 
                    Gilles.


