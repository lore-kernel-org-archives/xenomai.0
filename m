Message-ID: <53BCF35E.1090402@xenomai.org>
Date: Wed, 09 Jul 2014 09:46:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin #2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/01/2014 06:48 PM, Matthias Schneider wrote:

> Please find enclosed another calling the check_processors() only when starting
> the scheduler and remembering its output. It is also adapted to the latest changes.
> Any comments will be appreciated.
>

I don't think checking the registry contents in the testsuite is worth 
it: the output format from the registry may change over time, leaving 
tests parsing this output unfixed and outdated (e.g. we would not 
receive any compilation error in case of mismatch). Besides, the tester 
may want to disable the registry support at build time.

-- 
Philippe.

