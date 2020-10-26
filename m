Subject: Re: build scripts for the WIP xenomai porting to kernel 5.4
References: <20201016033638.GB5581@linux.intel.com>
 <0ba45dfa-4755-c627-e1fd-9f2c32ea8b8a@siemens.com>
 <9153481d-6df6-314f-c2c0-f413a34fb815@siemens.com>
 <20201021114329.GA4344@linux.intel.com>
 <88232cd0-0713-4e45-bad2-e22acdeb7632@siemens.com>
 <3a85c6c8-6792-40d1-5ef2-6ee634fc3c91@siemens.com>
 <20201022114938.GA8098@linux.intel.com>
 <39ccbc86-3f64-0941-241b-30e2431468cf@siemens.com>
 <20201022132522.GA9776@linux.intel.com>
 <ae889a3f-40c1-d22e-c97b-807fe2ab7b5f@siemens.com>
 <20201023090407.GA16088@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6ca34337-dd2f-3727-a014-f76d6721a647@siemens.com>
Date: Mon, 26 Oct 2020 08:35:10 +0100
MIME-Version: 1.0
In-Reply-To: <20201023090407.GA16088@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fino Meng <fino.meng@linux.intel.com>
Cc: xenomai@xenomai.org

On 23.10.20 11:04, Fino Meng wrote:
> be aware of RTNET and RTIPC part still have compile error, I didn't
> enable them in .config yet. hope can fix them next week.

Do you have patches for RTnet and Analogy already? RTIPC is fixed in
next. I'm currently trying to get CI fully running.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

