Message-ID: <540A23A6.8040205@xenomai.org>
Date: Fri, 05 Sep 2014 22:57:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140905184346.GN17690@csclub.uwaterloo.ca>
 <540A0A92.2000405@xenomai.org> <20140905191447.GO17690@csclub.uwaterloo.ca>
 <540A19DC.10507@xenomai.org> <540A1B2C.2050309@xenomai.org>
 <540A1DA7.8090906@xenomai.org> <20140905205404.GP17690@csclub.uwaterloo.ca>
In-Reply-To: <20140905205404.GP17690@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 09/05/2014 10:54 PM, Lennart Sorensen wrote:
> On Fri, Sep 05, 2014 at 10:31:35PM +0200, Gilles Chanteperdrix wrote:
>> Just tried a fresh build with minimal flags, simply:
>>
>> configure --enable-debug CFLAGS="-fomit-frame-pointer"
>> --host=arm-linux-gnueabihf
>> make
>> arm-linux-gnueabihf-gdb src/skins/common/.libs/libxenomai.so.0.0.0
>>
>> and gdb says it can find symbols. (-fomit-frame-pointer is needed with
>> the toolchain I use, otherwise gcc complains that it can not use the r7
>> register).
> 
> I tried adding that option, and still gdb says no symbols.
> 
> Toolchain is debian wheezy's gcc 4.6, and everything is natively compiled.
> 

Do you build the package manually, like I just did? Or do you use the
debian/rules stuff?

-- 
                                                                Gilles.

