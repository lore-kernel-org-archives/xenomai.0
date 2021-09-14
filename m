Subject: Re: (rt_)printf and virtual memory
References: <cf751850-8771-6120-e615-1fb80566a9a5@tin.it>
 <44a8a3ac-edf9-9169-ed3d-2a299a3e4ce5@siemens.com>
From: "Mauro S." <mau.salvi@tin.it>
Message-ID: <71420d57-c044-dcb0-441c-c02e39910f0c@tin.it>
Date: Tue, 14 Sep 2021 08:07:41 +0200
MIME-Version: 1.0
In-Reply-To: <44a8a3ac-edf9-9169-ed3d-2a299a3e4ce5@siemens.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it-IT
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 09/09/21 20:44, Jan Kiszka ha scritto:
> On 07.09.21 11:21, Mauro S. via Xenomai wrote:

..snip..

>>
>> Starting from a number of tasks > 4, the VMEM got a jump and then
>> increases very rapidly.
>>
>> Is it normal? Or I'm misusing the rt_printf?
> 
> No, that's related to glibc's internal memory allocation strategy. I
> didn't dig into details, but you can easily trigger enormous virtual
> memory reservations (which are not real memory, as we know) by adding a
> pre-thread malloc(1) to your program - without using rt_printf.
> 
> Jan
> 

Hi Jan,

ok thank you.

Regards

-- 
Mauro

