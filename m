Subject: =?UTF-8?B?UmU6IOKAmFNDSEVEX05PUk1BTOKAmSBub3QgcHJvdmlkZWQgYnkgWGVu?=
 =?UTF-8?Q?omai_headers?=
References: <AM0PR07MB5572F0A0E8B2B7C0DE7D5C87B5860@AM0PR07MB5572.eurprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <7638ce4c-03ab-8d8b-5851-4a4e30274247@web.de>
Date: Sun, 13 Jan 2019 11:25:50 +0800
MIME-Version: 1.0
In-Reply-To: <AM0PR07MB5572F0A0E8B2B7C0DE7D5C87B5860@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Giulio Moro <g.moro@qmul.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 13.01.19 04:08, Giulio Moro via Xenomai wrote:
> The docs for sched_setscheduler_ex() [1] and pthread_setscheparam_ex()[2]  claim that among the valid values for policy there is  "SCHED_NORMAL"
> 
> however, SCHED_NORMAL is not provided by any of the Xenomai headers, so you get a compile-time error.
> 
> [1] https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__scheduler.html#ga796071f20fd35a5e05972157745728af
> [2] https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__sched.html#ga405020019f5df8c7e74d30fd457384ed
> 

Yes, SCHED_NORMAL is an alias for SCHED_OTHER, but only the latter is available 
through pthread.h. We should probably change the constant here to avoid that 
confusion. Patches welcome.

BTW, you could use the SCHED_NORMAL definition by including <linux/sched.h>, but 
that should not be required.

Jan

