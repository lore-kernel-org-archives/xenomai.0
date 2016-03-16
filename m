Date: Wed, 16 Mar 2016 06:56:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160316055609.GC6555@hermes.click-hack.org>
References: <tencent_43A1242B10392F742BD72EDA@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tencent_43A1242B10392F742BD72EDA@qq.com>
Subject: Re: [Xenomai] error: implicit declaration of function '__mtmsrd'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?2012=972012?= <643651564@qq.com>
Cc: xenomai <xenomai@xenomai.org>

On Wed, Mar 09, 2016 at 10:41:48AM +0800, 2012=972012 wrote:
> When I compile the kernel, there are some errors.
>=20
> The detailed compile output is here:
> root@ubuntu:/home/ling/linux-3.14.44# make ARCH=3Dpowerpc CROSS_COMPILE=
=3Dpowerpc-fsl-linux- uImage
> scripts/kconfig/conf --silentoldconfig Kconfig

Strange, because Xenomai nightly build test builds for many powerpc,
without any error:
http://xenomai.org/build-test-stable/#powerpc

--=20
					    Gilles.
https://click-hack.org

