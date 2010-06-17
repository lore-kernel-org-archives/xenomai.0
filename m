Message-ID: <4C1A040F.4030209@domain.hid>
Date: Thu, 17 Jun 2010 13:16:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinRyxZ-BB_VwB2XPYwIPik8to_eynd-c-nNulQ1@domain.hid>
	<4C19EDA4.2030601@domain.hid>
In-Reply-To: <4C19EDA4.2030601@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] application make file
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Everett Wang wrote:
>> Hi All,
>>
>> Now my application based user space xenomai has a few files and I want
>> to construct a Makefile to compile them. I looked at the
>> Makefiles in examples folder. It is not straight forward to modify one
>> for myself. I have c files and header files.  It is possible to get
>> a makefile with minor changes so it can automatically find the
>> dependence of c and h files?
> 
> You can do this quite easily with GNU make.

Namely:
http://www.gnu.org/software/make/manual/html_node/Automatic-Prerequisites.html#Automatic-Prerequisites

-- 
					    Gilles.

