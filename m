Message-ID: <52EA816B.9060305@xenomai.org>
Date: Thu, 30 Jan 2014 17:44:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1391006203.6916.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <52E950FB.70400@xenomai.org> <52E95E66.2060905@xenomai.org>
 <201401301624.25756.paul_c@tuxcnc.org>
In-Reply-To: <201401301624.25756.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debuild of xenomai failing: Directory nonexistent
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/30/2014 05:24 PM, Paul wrote:
> On Wednesday 29 January 2014, Gilles Chanteperdrix wrote:
>> On 01/29/2014 08:05 PM, Gilles Chanteperdrix wrote:
>>> On 01/29/2014 03:36 PM, Huub Van Niekerk wrote:
>>>> Hi,
>>>>
>>>> I'm trying to build the xenomai libs on Ubuntu 12.04 armhf
>>>> according to
>>>> http://www.xenomai.org/index.php/Building_Debian_packages. It goes
>>>> wrong with a message "cannot create
>>>> <user>/Downloads/xenomai-2.6.3/debian/libxenomai1/etc/udev//xenoma
>>>> i.rules: Directory nonexistent". Any idea what the cause of this is
>>>> ? I did it before on x86, which went great.
>>>
>>> I do not see why this even works on x86... Please try the following
>>> patch:
>>
>> Please try this one instead:
>>
>> diff --git a/debian/libxenomai1.install b/debian/libxenomai1.install
>> index 093956b..9c732f5 100644
>> --- a/debian/libxenomai1.install
>> +++ b/debian/libxenomai1.install
>> @@ -1 +1,2 @@
>> +etc/udev/rules.d/*
>>   usr/lib/*.so.*
>> diff --git a/debian/rules b/debian/rules
>> index 3915fd6..c842986 100755
>> --- a/debian/rules
>> +++ b/debian/rules
>> @@ -61,14 +61,12 @@ install: build
>>   	dh_testroot
>>   	dh_prep
>>   	dh_installdirs
>> +	mkdir -p $(CURDIR)/debian/tmp/etc/udev/rules.d
>
> This shouldn't be necessary as etc/udev/rules.d is listed in
> libxenomai1.dirs - dh_installdirs uses this to create the target
> dirctories.
>
>>   	$(MAKE) install DESTDIR=$(CURDIR)/debian/tmp/
>>   	dh_install --sourcedir=$(CURDIR)/debian/tmp
>>   	# xeno-config should be only in libxenomai-dev
>>   	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
>>   	rm -f
>> $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-config.1
>> -	for f in $(CURDIR)/ksrc/nucleus/udev/*.rules ; do \
>> -	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules
>> ; \ -	done
>
> This is needed so that the udev rules get copied across.

If the directory /etc/udev/rules.d exists, Xenomai's "make install", 
should copy the rules itself.


-- 
					    Gilles.

