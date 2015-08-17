Message-ID: <55D1EE0A.6030100@gatech.edu>
Date: Mon, 17 Aug 2015 10:22:02 -0400
From: "Yogi A. Patel" <yapatel@gatech.edu>
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
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


>> diff --git a/lib/analogy/calibration.c b/lib/analogy/calibration.c
>> index b50cb2f..d062a00 100644
>> --- a/lib/analogy/calibration.c
>> +++ b/lib/analogy/calibration.c
>> @@ -105,7 +105,10 @@ static inline int read_int(int *val, struct _dictionary_
>> *f, const char *subd,
>>
>>          *val = iniparser_getint(f, str, 0xFFFF);
>>          if (*val == 0xFFFF)
>> +       {
>> +               *val = -1;
>>                  ret = -ENOENT;
> this is not correct.
> the coefficient was not found and so an error must be return.
Yes, I agree that an error must be returned. The problem is that *val is 
pointing to 0XFFFF - which is nb_elements. So when you check 
if(nb_elements < 0), it still proceeds, rather than returning an error 
as it should.

Thanks for sending your file. I am absurdly confused as to why I don't 
get an output section..have you tried this with any other cards?

