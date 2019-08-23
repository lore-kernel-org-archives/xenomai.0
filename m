Subject: Re: A potential Xenomai Mutex issue
References: <DM6PR07MB596162CF3DD4EB4071336D26E7A50@DM6PR07MB5961.namprd07.prod.outlook.com>
 <43f9470f-ed47-0a2a-71f5-ca9bca08879a@siemens.com>
 <DM6PR07MB59614BFAE90AE8DA6B49769EE7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
 <2f51ad42-4be3-606d-dbdf-ee036bd562de@siemens.com>
 <DM6PR07MB59610EC30F9B7433FBD53E35E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
 <d3ed1327-3026-6489-a66b-56f9680f08d2@siemens.com>
 <DM6PR07MB596161BCD969C8C69F2E8D31E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
 <eb28e913-89d2-6141-c37d-e2c5e0a540ec@siemens.com>
 <DM6PR07MB59618611F0A6CBCAF565B856E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ad012a80-66b5-3e72-f585-6eb3f3045855@siemens.com>
Date: Fri, 23 Aug 2019 20:17:41 +0200
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB59618611F0A6CBCAF565B856E7A40@DM6PR07MB5961.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "DIAO, Hanson (DI PA CI RC R&D SW2)" <hanson.diao@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 23.08.19 19:27, DIAO, Hanson (DI PA CI RC R&D SW2) wrote:
> No, the thread was not doing any migrations to secondary mode.
> 

Then I would suggest to use a debugger in order to step through this fairly 
simple, nicely single-threaded case. That should reveal if you are really taking 
the same lock or why rt_mutex_lock decides to not increment lockcnt.

Jan

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Friday, August 23, 2019 12:19 PM
> To: DIAO, Hanson (DI PA CI RC R&D SW2) <hanson.diao@siemens.com>
> Cc: xenomai@xenomai.org
> Subject: Re: A potential Xenomai Mutex issue
> 
> On 23.08.19 17:49, DIAO, Hanson (DI PA CI RC R&D SW2) wrote:
>> Hi Jan,
>>
>> Thank you for your reply. Please see my following comments. Thank you so much.
>>
>>
>> For the issue 2 the test case is very simple. The lock sequence is as below. After ReadReg function I checked the lockcnt. The lockcnt is 1.
>> Int writeReg()
>> {
>>        SMILock();
>>        ReadReg();
>>        ......
>>        SMIUnlock();
>> }
>>
>> Int ReadReg()
>> {
>>        SMILock();
>>        /*  Check the lockcnt here. It is still 1, should be 2 */
>>        ........
>>        ......
>>        SMIUnlock();
>> }
> 
> Is the thread doing any migrations to secondary mode between the entry of writeReg and the checking of lockcnt?
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

