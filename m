MIME-Version: 1.0
In-Reply-To: <4E6DCD41.6000209@domain.hid>
References: <4E6DC272.9050305@domain.hid> <4E6DCC00.50305@domain.hid>
	<4E6DCD41.6000209@domain.hid>
Date: Mon, 12 Sep 2011 11:41:18 +0200
Message-ID: <CA+W0MVxOSRyKjFYSOn1aWzP+tQ0AavaS8Ot8mxv=mxjKror5mQ@mail.gmail.com>
From: varname <varname@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Undefined 'pc_sysrootdir' in libxenomai_posix.pc
	?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 12 September 2011 11:13, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/12/2011 11:08 AM, Gilles Chanteperdrix wrote:
>> On 09/12/2011 10:27 AM, varname wrote:
>>> Trying to use pkg-config with 2.6.0-rc2 results in the following error
>>> message:
>>>
>>> =A0 =A0Variable 'pc_sysrootdir' not defined in
>>> '/home/test/usr/xenomai-2.6.0-rc2/lib/pkgconfig/libxenomai_posix.pc'
>>>
>>> Same behaviour in rc1.
>>>
>>> Removing ${pc_sysrootdir} seems to work, but I'm not sure that is the
>>> correct fix for this.
>>
>> No, the correct use of pkg-config is to pass the PKG_CONFIG_SYSROOT_DIR
>> environment variable.
>>
>> if the staging variable contains the directory which was used as DESTDIR
>> when installing xenomai, you should run pkg-config with the following
>> environment variables set:
>>
>> PKG_CONFIG_LIBDIR=3D${staging}/usr/lib/pkgconfig:${staging}/usr/share/pk=
gconfig
>>
>> PKG_CONFIG_SYSROOT_DIR=3D${staging}
>>
>
> See:
> http://www.flameeyes.eu/autotools-mythbuster/pkgconfig/cross-compiling.ht=
ml

Right, that explains it. Sorry for the noise.

