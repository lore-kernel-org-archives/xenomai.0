Message-ID: <50EE88BE.7090405@xenomai.org>
Date: Thu, 10 Jan 2013 10:24:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50EB4DB3.4040207@xenomai.org>
In-Reply-To: <50EB4DB3.4040207@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian squeeze packages preview for the
	amd64	architectures
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 01/07/2013 11:35 PM, Gilles Chanteperdrix wrote:

> 
> Hi,
> 
> For the Debian squeeze users, the xenomai packages are available on
> xenomai server, for the amd64 architecture. To use them, add:
> 
> deb http://www.xenomai.org/debian squeeze main
> 
> to /etc/apt/sources.list, then:
> apt-get update
> apt-get install xenomai-keyring
> apt-get install linux-image-3.5.7-xenomai-2.6.2 xenomai-runtime


Hi again,

for those interested in debian packages, the linux-image package was
renamed linux-image-3.5.7-xenomai-2.6.2-amd64 and CONFIG_FTRACE disabled
to improve latencies, and the i686 versions of the packages were added.

Regards.

-- 
                                                                Gilles.

