Message-ID: <516F1510.3030608@xenomai.org>
Date: Wed, 17 Apr 2013 23:33:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAG5EsAGn8oNQkH-OkEpS6NHjW7y1vZfp5HjV3+FTGi-eh667pg@mail.gmail.com>
	<00DF7AD9-868B-4AFC-B385-8C47F8522E4B@mah.priv.at>
In-Reply-To: <00DF7AD9-868B-4AFC-B385-8C47F8522E4B@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm and rasberry-pi GPIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 04/17/2013 10:59 PM, Michael Haberler wrote:

> Ross,
> 
> any reason not to use just userland memory mapped port I/O like with this library: http://www.airspayce.com/mikem/bcm2835 ?
> 
> that worked fine for me with a userland RT thread, no drivers needed


It is a bad idea to access GPIO registers in user-space via memory
mapped I/O: you will not get the mutual exclusion the kernel driver
gives you.

-- 
                                                                Gilles.

