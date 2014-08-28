Message-ID: <53FF5B81.7030408@xenomai.org>
Date: Thu, 28 Aug 2014 18:40:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACreCV+9seA7yp8gmjvOb6CQ7-Fbt-HyQ6YAoB_dqtmqmyvy7Q@mail.gmail.com>	<53FDFD27.2010207@xenomai.org>	<CACreCV+cQTO-5iFCCvC15VxNzXuvKkLN+_gUTex-r3Y1cByUkw@mail.gmail.com>	<53FF33CE.10303@xenomai.org>	<D024AFFD.53F9%donald.poole@swri.org>
 <CACreCV+8qTgd6y0UuRmMQEhX_mM4PfxP2yjANerZ07SmwkmkEg@mail.gmail.com>
In-Reply-To: <CACreCV+8qTgd6y0UuRmMQEhX_mM4PfxP2yjANerZ07SmwkmkEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ODROID-U3 porting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>, "Poole Jr, Donald R." <donald.poole@swri.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/28/2014 06:34 PM, GP Orcullo wrote:
> So far it passes all the regression tests except for the switchtest.

What error do you get with switchtest ? If pthread_create fails with
resource unavailable error, see:

http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#pthread_create_Resource_temporarily_unavailable

If this is another error, please post the error message and kernel log here.

-- 
                                                                Gilles.

