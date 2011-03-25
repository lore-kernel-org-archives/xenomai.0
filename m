Message-ID: <4D8C7153.5010606@domain.hid>
Date: Fri, 25 Mar 2011 11:41:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <e9120c91-7bfe-489f-a80d-16e2bfdec46c@domain.hid>
In-Reply-To: <e9120c91-7bfe-489f-a80d-16e2bfdec46c@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] 'cannot map MAYDAY page' on blackfin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?0JTQtdC90LjRgSDQm9Cw0YLRi9GI0LXQsg==?= <latyshev@domain.hid>
Cc: xenomai@xenomai.org

=D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=9B=D0=B0=D1=82=D1=8B=D1=88=D0=B5=D0=B2=
 wrote:
> Hi All. I am trying to run xenomai on blackfin ADZS-BF537-EZLITE
> board, but I'm getting an error when trying to execute any test
> programs like arith, clocktest etc.
>=20
>=20
> Software versions: linux-2.6.35.7 xenomai-2.5.5.2
>=20
>=20
> example:
>=20
>=20
> # /usr/xenomai/bin/arith Xenomai: binding failed: Cannot allocate
> memory.
>=20
>=20
> # dmesg | tail -5
>=20
> [ 7.288690] PHY: 0:01 - Link is Up - 100/Full [ 7.502574] Looking up
> port of RPC 100005/1 on 192.168.4.9 [ 7.593737] VFS: Mounted root
> (nfs filesystem) on device 0:11. [ 7.601396] Freeing unused kernel
> memory: 104k freed [ 300.787988] Xenomai: arith[330] cannot map
> MAYDAY page
>=20
>=20
> All happens in root console.
>=20
>=20
> I found that the error returns from the function
> validate_mmap_request when the flag BDI_CAP_MAP_DIRECT is checked in
>  file->f_mapping->backing_dev_info->capabilities while mapping memory
> in map_mayday_page. Looks like this flag must be set for /dev/rtheap,
> but it's not. Is it bug on NOMMU system or maybe my fault? I've build
> kernel and system as explained in README.INSTALL.

Hi,

This issue does not happen when we validate Xenomai. Could you give us
more information, such as the .config for your kernel, and the options
you pass on configure command line?

Regards.

--=20
					    Gilles.


