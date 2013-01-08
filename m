From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Tue, 8 Jan 2013 10:12:47 +0100
References: <50EB4DB3.4040207@xenomai.org>
In-Reply-To: <50EB4DB3.4040207@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201301081012.47861.leo@alaxarxa.net>
Subject: Re: [Xenomai] Debian squeeze packages preview for the amd64
	architectures
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

A Dilluns 07 Gener 2013, Gilles Chanteperdrix va escriure:
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
> 
> You should then be able to reboot on the new kernel, and launch:
> xeno latency
> 
> These packages are a preview version, not really 2.6.2, but not yet the
> next release.
> 

great!!!

Please Gilles, the linux image is produced using an standard stock version 
(just patched with xenomai)?

Leo

-- 
--
Linux User 152692
Catalonia

