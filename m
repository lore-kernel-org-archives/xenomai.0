References: <38db19d5-b6c4-1948-b2ce-ef7270350e0b@iit.it>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <632ac67c-8bee-3f25-c395-d52c06b5ea81@xenomai.org>
Date: Thu, 11 May 2017 17:25:15 +0200
MIME-Version: 1.0
In-Reply-To: <38db19d5-b6c4-1948-b2ce-ef7270350e0b@iit.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] linker error installing xenomai-3.0.4 using gcc-6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alessio margan <alessio.margan@iit.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/11/2017 04:43 PM, alessio margan wrote:
> Hi,
> 
> using gcc-6 to install xenomai 3.0.4 libraries give me errors probably
> due to gcc-6 compiled with --enable-default-pie option.
> 
> "/usr/bin/ld -r and -pie may not be used together"
> 
> as workaround I've used gcc-5.
> 
> How could solve this issue ?
> 

The configure script considers CC/LD flags which are preset at
invocation time, so you may want to try this:

.../configure CFLAGS=-no-pie CXXFLAGS=-no-pie LDFLAGS=-no-pie <other
switches>

-- 
Philippe.

