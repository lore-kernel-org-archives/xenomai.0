Message-ID: <540B3B39.4000704@xenomai.org>
Date: Sat, 06 Sep 2014 18:50:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140905184346.GN17690@csclub.uwaterloo.ca>
 <201409052226.00161.paul_c@tuxcnc.org> <540B091C.8060604@xenomai.org>
 <201409061616.46205.paul_c@tuxcnc.org>
In-Reply-To: <201409061616.46205.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to get debug symbols in xenomai libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

On 09/06/2014 05:16 PM, Paul wrote:
> On Saturday 06 September 2014, Gilles Chanteperdrix wrote:
>> On 09/05/2014 11:25 PM, Paul wrote:
>>> On Friday 05 September 2014, Gilles Chanteperdrix wrote:
>>>> On 09/05/2014 11:15 PM, Lennart Sorensen wrote:
>>>>> On Fri, Sep 05, 2014 at 11:04:35PM +0200, Gilles Chanteperdrix
>>>
>>> wrote:
>>>>>> On 09/05/2014 11:03 PM, Lennart Sorensen wrote:
>>>>>>> On Fri, Sep 05, 2014 at 10:57:10PM +0200, Gilles Chanteperdrix
>>>
>>> wrote:
>>>>>>>> On 09/05/2014 10:54 PM, Lennart Sorensen wrote:
>>>>>>>>> On Fri, Sep 05, 2014 at 10:31:35PM +0200, Gilles
>>>>>>>>> Chanteperdrix
>>>
>>> wrote:
>>>>>>>>>> Just tried a fresh build with minimal flags, simply:
>>>>>>>>>>
>>>>>>>>>> configure --enable-debug CFLAGS="-fomit-frame-pointer"
>>>>>>>>>> --host=arm-linux-gnueabihf
>>>>>>>>>> make
>>>>>>>>>> arm-linux-gnueabihf-gdb
>>>>>>>>>> src/skins/common/.libs/libxenomai.so.0.0.0
>>>>>>>>>>
>>>>>>>>>> and gdb says it can find symbols. (-fomit-frame-pointer is
>>>>>>>>>> needed with the toolchain I use, otherwise gcc complains
>>>>>>>>>> that it can not use the r7 register).
>>>>>>>>>
>>>>>>>>> I tried adding that option, and still gdb says no symbols.
>>>>>>>>>
>>>>>>>>> Toolchain is debian wheezy's gcc 4.6, and everything is
>>>>>>>>> natively compiled.
>>>>>>>>
>>>>>>>> Do you build the package manually, like I just did? Or do you
>>>>>>>> use the debian/rules stuff?
>>>>>>>
>>>>>>> I use the debian/rules, but I set
>>>>>>> DEB_CFLAGS_APPEND=-fomit-frame-pointer and I added
>>>>>>> --enable-debug to the configure line in debian/rules and I set
>>>>>>> DEB_BUILD_OPTIONS=nostrip
>>>>>>
>>>>>> Could you try a manual build?
>>>>>
>>>>> That makes installing such a pain and the gcc lines had all the
>>>>> right arguments (-g -fomit-frame-pointer etc).  And we did want
>>>>> to debug with as close to the normal runtime build as possible.
>>>>
>>>> You do not need to run "make install"
>>>> Just run configure --enable-debug
>>>> Then make
>>>> Then try gdb on the compiled libxenomai.so.0.0.0
>>>>
>>>> There are two layers of Makefileries, thee aim is to find where
>>>> the problem is coming from, not to use this as a solution.
>>>
>>> dh_strip in debian/rules is the guilty party here - It is
>>> responsible for stripping debug symbols from binary executables and
>>> libraries.
>>
>> I am not sure this is the issue, since Lennart passes the "nostrip"
>> directive, and says that the file utility says that the libraries are
>> not stripped.
> 
> Apologies - Missed the bit about passing nostrip via DEB_BUILD_OPTIONS.
> 
>> Anyway, packages like libc6 have debug symbols in a separate package
>> from the main binary package. Is this complicated to achieve?
> 
> Very simple to achieve. The bulk of it is a cut'n'paste job in 
> debian/control plus a couple of lines in debian/rules. Please see 
> attached patch.

Merged, thanks a lot. Lennart, could you check whether it works in your
case?

Regards.

-- 
                                                                Gilles.

