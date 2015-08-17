Message-ID: <55D1E400.2060507@xenomai.org>
Date: Mon, 17 Aug 2015 09:39:12 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <55C17C8E.5000909@gatech.edu> <55C3AEBE.9080603@xenomai.org>
 <55C3C3F8.1090808@gatech.edu> <55C3C7F4.1030107@xenomai.org>
 <12F45B9B-70C3-4278-BA0E-DFC26E19DBF0@gatech.edu>
 <55C495D6.2070706@xenomai.org>
 <06B32287-9FE2-42E5-BC2B-E9C807D0BD69@gatech.edu>
 <55C4BD22.9060809@xenomai.org>
 <EB72B89E-CA71-4F7F-9A35-99A87C282A61@gatech.edu>
 <55C515F0.8080307@xenomai.org>
 <45806C53-526E-425C-AEA4-70B2A22EA364@gatech.edu>
 <55C51965.2020206@xenomai.org>
 <933604EB-994B-4CE9-BA38-DB404CA0811D@gatech.edu>
 <55C522AE.8030403@xenomai.org> <55C9EAA6.6030503@gatech.edu>
 <55D15EDB.4060107@gatech.edu> <55D1E001.5080905@xenomai.org>
In-Reply-To: <55D1E001.5080905@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/17/2015 09:22 AM, Jorge Ramirez Ortiz wrote:
> On 08/17/2015 12:11 AM, Yogi A. Patel wrote:
>>
>>>> please pull again from http://git.xenomai.org/xenomai-jro.git/log/?h=devel
>> It took some time, but I was able to get the process to *run* - but not work.
>>
>> I had to make the following modifications to the calibration.c file to get this
>> to work on 3 different machines:
> 
> none of these modifications are really valid.
> you are probably forcing analogy to swallow an invalid calibration file.
> 
>>

> 
>> @@ -226,7 +229,7 @@ int a4l_read_calibration_file(char *name, struct
>> a4l_calibration_data *data)
>>                 if (nb_elements < 0 ) {
>>                         /* AO is optional */
>>                         if (!strncmp(subdevice[k], AO_SUBD_STR,
>> sizeof(AO_SUBD_STR)))
>> -                            break;
>> +                               return 0;
> 

actually I am obviously wrong here. this is needed.
it went unnoticed on my tests (it is unusual not to have an A0 subdevice)
will pick it.


