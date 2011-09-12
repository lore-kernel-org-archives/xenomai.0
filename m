Message-ID: <4E6DCD41.6000209@domain.hid>
Date: Mon, 12 Sep 2011 11:13:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E6DC272.9050305@domain.hid> <4E6DCC00.50305@domain.hid>
In-Reply-To: <4E6DCC00.50305@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: varname <varname@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 09/12/2011 11:08 AM, Gilles Chanteperdrix wrote:
> On 09/12/2011 10:27 AM, varname wrote:
>> Trying to use pkg-config with 2.6.0-rc2 results in the following error 
>> message:
>>
>>    Variable 'pc_sysrootdir' not defined in 
>> '/home/test/usr/xenomai-2.6.0-rc2/lib/pkgconfig/libxenomai_posix.pc'
>>
>> Same behaviour in rc1.
>>
>> Removing ${pc_sysrootdir} seems to work, but I'm not sure that is the 
>> correct fix for this.
> 
> No, the correct use of pkg-config is to pass the PKG_CONFIG_SYSROOT_DIR
> environment variable.
> 
> if the staging variable contains the directory which was used as DESTDIR
> when installing xenomai, you should run pkg-config with the following
> environment variables set:
> 
> PKG_CONFIG_LIBDIR=${staging}/usr/lib/pkgconfig:${staging}/usr/share/pkgconfig
> 
> PKG_CONFIG_SYSROOT_DIR=${staging}
> 

See:
http://www.flameeyes.eu/autotools-mythbuster/pkgconfig/cross-compiling.html

-- 
					    Gilles.

