Message-ID: <4DA6E39A.6030504@domain.hid>
Date: Thu, 14 Apr 2011 14:07:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <F73025C3-F590-4CB7-A8E1-0EFF62E9A656@domain.hid>	<4D9EB884.6020804@domain.hid>	<205D3924-0110-4DA7-838B-DF40BDBE6702@domain.hid>	<4D9FB431.6010203@domain.hid>
	<9948C373-EE10-42D0-A854-DC6A6C38B830@domain.hid>
	<4DA433B7.5020608@domain.hid>
	<C373CD6F-10C0-4368-AF4C-10E406D6B52A@nolanw.ca>
In-Reply-To: <C373CD6F-10C0-4368-AF4C-10E406D6B52A@nolanw.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Total system lockup doing anything real-time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nolan Waite <nolan@domain.hid>
Cc: xenomai@xenomai.org

Nolan Waite wrote:
> On 2011-04-12, at 5:12 AM, Gilles Chanteperdrix wrote:
> 
>> In the kernel configuration. Could you try changing the following 
>> configuration options: CONFIG_FTRACE to n CONFIG_SECURITY to n 
>> CONFIG_DEBUG_RODATA to n CONFIG_KGDB to n CONFIG_AUDIT to n Could
>> you to try a 64 bits kernel (with the 32 bits compatibility layer, 
>> it should work with a 32 bits rootfs)?
> 
> I changed these settings as asked and switched to a 64-bit kernel (I
> had problems cross-compiling, my own fault I'm sure, so I just
> grabbed the x86_64 version of Ubuntu 10.04, but used the same kernel
> source tree I was using before), and now latency runs no problem!
> I've attached the .config here just in case anyone's following along.
> 
> 
> I'll reenable Analogy or Comedi and see how that goes, but for now
> things are looking good. Let me know if there's any logs or anything
> you'd like to see.
> 
> Thanks so much for your walking me through the troubleshooting. Very
> much appreciated.

Well, I am not sure we are through. IMO, we should try and find which of
the options solves the issue, starting with the 64 bits build.

-- 
					    Gilles.

