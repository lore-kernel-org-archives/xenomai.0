Message-ID: <518F9EB8.5010509@xenomai.org>
Date: Sun, 12 May 2013 15:52:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1UbCuV-0003Mx-J1@xenomai.org> <518E7659.7080503@xenomai.org>
In-Reply-To: <518E7659.7080503@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : lib/cobalt: use common
 console message prefix
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 05/11/2013 06:48 PM, Gilles Chanteperdrix wrote:
> On 05/11/2013 06:44 PM, git repository hosting wrote:
>
>>   static void sigill_handler(int sig)
>>   {
>> -	fprintf(stderr, "Xenomai disabled in kernel?\n");
>> +	const char *m = "Xenomai disabled in kernel?\n";
>
>
> I believe you want static const char m[] =
> otherwise sizeof(m) will be 4 or 8.
>

Fixed, thanks.

-- 
Philippe.

