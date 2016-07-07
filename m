From: Wojciech Domski <wojciech.domski@gmail.com>
References: <80829334.1467803968128.JavaMail.root@webmail1>
 <577CECCE.50701@xenomai.org>
Message-ID: <b8001b58-62d7-f3aa-d6dd-b4c9ba846861@gmail.com>
Date: Thu, 7 Jul 2016 11:08:41 +0200
MIME-Version: 1.0
In-Reply-To: <577CECCE.50701@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] request about daq board.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez <jro@xenomai.org>, xenomai@xenomai.org


W dniu 06.07.2016 o 13:34, Jorge Ramirez pisze:
> On 07/06/2016 01:19 PM, 성주환 wrote:
>> Hello I'm a new xenomai starter.  I have a one question. From the 
>> xenomai website, I saw that Sensoray s526 is fit to xenomai. But I 
>> ordered Sensoray s626 , Is it possible using s626 board instead of 
>> s526?? Thank you for you respond
>
> Unfortunately the driver for the s626 was never merged - Wojciech 
> Domski in copy - might have a version that you could use.
>
> Wojciech please let me know if you would like to attempt upstreaming 
> the driver again (I think most of the issues were about coding 
> standards not functional)
>
>
As Jorge said I have prepared the driver for s626. The very first 
version of the driver is on xenomai's git repository. However, the 
updated version of s626 was never merged with the xenomai tree.
You can find current driver and sample application at my github:
https://github.com/wdomski/s626

Best regards,

Wojciech Domski

www.domski.pl | www.blog.domski.pl


