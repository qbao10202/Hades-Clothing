SET FOREIGN_KEY_CHECKS=0;
CREATE DATABASE  IF NOT EXISTS `sales_app` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `sales_app`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: sales_app
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.18-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_product` (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image_content_type` varchar(100) DEFAULT NULL,
  `image_data` longblob DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (2,'TOPS','tops','T-shirts, polo shirts, tank tops 2','/uploads/categories/2/1752167368744_080425.jpg',NULL,5,1,'2025-07-10 17:09:28',NULL,NULL),(3,'BOTTOMS','bottoms','Pants, shorts, jeans','/uploads/categories/3/1751393203059_dsc04804_e0be9af53da54231be42e0a6da3932c6.jpg',NULL,3,1,'2025-06-29 07:57:42',NULL,NULL),(4,'OUTERWEARS','outerwears','Jackets, hoodies, sweaters','/uploads/categories/4/1752175631989_dsc09069_188126c239524a9cb4beb36c49925e34.jpg',NULL,4,1,'2025-07-10 19:27:13',NULL,NULL),(5,'UNDERWEARS','underwears','Underwear, socks','/uploads/categories/5/1752163696915_untitled_session0156_c644f3db69f74052bef5b087ebe22e2e.jpg',NULL,5,1,'2025-07-10 16:08:16',NULL,NULL),(6,'BAGS','bags','Backpacks, bags, accessories','/uploads/categories/6/1752175663315_dsc02268_598e261939cd4e76b39aefc724cabebc.jpg',NULL,6,1,'2025-07-10 19:27:43',NULL,NULL),(7,'ACCESSORIES','accessories','Caps, belts, jewelry','169070778_1067951744014704_5198766504034016573_n.jpg',NULL,8,1,'2025-07-18 04:18:38','image/jpeg',_binary ' \  \ ICC_PROFILE\0\0\0lcms\0\0mntrRGB XYZ  \ \0\0\0\0)\09acspAPPL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0 \ \0\0\0\0\0\ -lcms\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\ndesc\0\0\0 \0\0\0^cprt\0\0\\\0\0\0
wtpt\0\0h\0\0\0bkpt\0\0|\0\0\0rXYZ\0\0 \0\0\0gXYZ\0\0 \0\0\0bXYZ\0\0 \0\0\0rTRC\0\0\ \0\0\0@gTRC\0\0\ \0\0\0@bTRC\0\0\ \0\0\0@desc\0\0\0\0\0\0\0c2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0text\0\0\0\0FB\0\0XYZ \0\0\0\0\0\0 \ \0\0\0\0\0\ -XYZ \0\0\0\0\0\0\0\03\0\0 XYZ \0\0\0\0\0\0o \0\08 \0\0 XYZ \0\0\0\0\0\0b \0\0  \0\0\ XYZ \0\0\0\0\0\0$ \0\0 \0\0 \ curv\0\0\0\0\0\0\0\Z\0\0\0\ \ c k
 ?Q4! ) 2; FQw]\ kpz   | i }\ \ \ 0   \ \0JFIF\0\0\0\0\0\0 \ \0C\0 
\n		\n
\r\r\Z\Z)  )/\'%\'/9339GDG]]} \ \0C 
\n		\n
\r\r\Z\Z)  )/\'%\'/9339GDG]]} \ \0  \"\0 \ \0\0\0\0\0\0\0\0\0\0\0\0\0  \ \0\Z\0\0\0\0\0\0\0\0\0\0 \ \0\0\0\0\ 3 \ \  ;
03\ `  \ \ lA  ` \ ]f\ \ l+Y Mf\ \ l ֝ : \ L,\ \ \  \ gY   af (\ \ 12 \ g\Z\ \ \ ]f\ \ l fk\Z큮η903 \  \   pmKX  dK BDL`\0D d\0h\0@	^ && \"© \0!& &a% MDX\  \0\0  ĥQ\"Z Xa 52 je  D$ Z D H  H    - 	!\"\"AXR H  \n\0 a& $\0 \"-\n  \ \ Z YQ c %P LL \ U\"\0  $  	 Z	$!\"\"«\0	 -@$BD$DZ$h\0 92I`X\0  -U  @,+2!\"    H I$ @\0\0\0\0  \0 \ H  H \0\n&\Z%f *  \03$\ $Bb LH\0\0\"D1!a$$\0ɏ  &6A  cd J 
	(\0HZ +mP y \ % Ơ5h @* \ P   	H\ R    DL\0	  ŋ*d   ,   հ \ \Z\ \ \0\0\0D H  \0cͭ\ \ AH&i- A\  `*    +aU \"\ @PPDňI, ,  l*  ʭ RĤd UY 5 @B \"2]VQd\ \Z \0\n\ - [1 U\n&J\ %,  RԑU VdZ \ TY[\0\0\0\0[*YPY *5P\"`D\ u\\l AH\0\"\0\0e \r l\  cd2 U`\0\0\0\0YUZ  *Y[\0\0\0\0\0\0\0 \ 0	f\ ^\ f\ X\Z mP\0 et9\0  խ  \0l5X\0\0\0V\ J$ 4 \ R\  \n\ \n\ $\0\0\0 \"\0D  {M\"V P\0 \"Ef\0    \ ʀ HD ڠ ,  *[+`((0 D \0$BD$@AB  2  rl X\ 0     UmP\"$d9J\0P	@ 	D  E Z  Օ [T     	\0+aYI	Z \0 Kb P  F9 WBN; Y 0 Y  j 	I * P $	 !\"\0Ɏ\ \ j   \ \ \ 0XH\0$B@\0EoR\0  P\"\ c 8     \ \ hHj DJXD    YDc&V) !d %J * \0,*    \0\0\0\0hlf 5 	 )[a   \\   \ \"$\ VZ$V\ \ 	j 2P$ؙ\ H  Q ^+% &Ւ\ \ \ \ \ d D \ YU H\0\ \  E VXUj $ʶ Mi\ 3Df Ԭ  \"    4!f[TK\ Y  UaDNt Ƣ 	6   7 \ 6    d B@\0\0\0\0	5T\ )  ֖jU0\0\ \ DZ\n U ¢MBD&Y ƪ  \'> ̡c&<  \ \ \ M  3) 	2\0\0\0\0\0\0\0\0\01 /5\\yiemR\ XUj  \"\0D \"\05   \ +- \ r,  қ \ & \ \ !2&@2\0\0\0L\ E \ aU VXUaU     |XKr*[ -R\ \ 1  V/\ 0 &9\ )6Ɩ \0 ْr\ )\ LY,J\ )  f \n * \0,*  E  J$\0\0 Kd\ XL\ V5H\ RR@ B\ )  K .+    V-I  2T\0c &  Fr %J&   \0I\"@\0\"\ X
 (   e,b  \ % p  \ P* k\\ UqD $\ $\  \0U`#&0 \ Q)3c)I	 I  BQ!i)* X p\r@    ¸gfn 6   H$DZ\r BQ0ALPD\0\0 EmP]56  # A)1aE\ ;L\ E fJ\0 (   WV    
\ \ \ & $c^\0,D \n aQ\0\ \0TD&\0\0T*B.  D \ ^b\ \0@ i+T	\'I 1z\ \ k)|3lnm\r\ \   \0 ށ\ L\0 h\r\0  )x\0\Z` 3 1΋ɏ$ \0\0 *\ ]RYZ  MZ\"\  ԫb\ ^f i  #rb\"K*[ dK\ \"aB\ \0 `\Z\0A  *(   c8\  ! E\ bk ي kk \ Q3UZ!h\ \ -fV\ \ f\ L  fi5 \ *\ \ %֯U     V& A\ \0  V\ @*  Rʗ  bf 2  \ F3-qF \ P  j\ - W%q\ ]Y K\ \ vbn  H f  2Ymk \ $  \ Z PP TX
   \0CS@\n    R\ @
ՋG,\ \ nZEjb 2V  \n_mb\ $   \ œb\ \ d\ %&\ h  \ k.B P \0 Q\0\r\0M\0  @-U@h TZ /`r  5W^61[  \ U\"\ R(ݑ$\ #\ f .< \  f DW;Z\ b\0\0\0DLP\n^ B\  \0*\"M@\0\nڄ )  \n  
(5\ Q\ zV+K- V UmED\ Z \ \ ɦc <\ t\\\ N  +\ i\ 72\ X\ e \ M2  Ȭ  Q$\rU R \"! DAeD*  ԫ  A0  Um\n H*7   \ -  \ r\  U    Ikc r\ fk\ K;3 6   ok6] >s\   {   \ 5 >[\ tㅛ^0.H ,  *f\ 5. - b  D\ DL\0+j *    \ 5I  R  D\ e - \ OZ\Z\ :\ \ \"zծ\\ \ rc \'z s ӝ\ 4 0\ \ \ Ƹ|<\ y \ X w  ;  \ J\   t p 1\ \ \ \ \ q ;   r ѥ *ڶ@B  \\ R   9   \ Z, \ A\nJȅJ PP׿ ӑ \"VD  H  UdURP  \  O   . Tr 1( fb ^q   Χ 
  j\   |\ \  Jfƕ CMnU v%b Ԅ UYD^*@A0  D\ \ Y  Pusa  ן&  \ &X\ 
x  c ec ,c \ \ Nb\ \Zr 7  U  >\ Ve[5*6 ~m  Z t n_8\ {Zv\ h   \ c \ Z\ 2 N x lT  +[Uk( \" b0&-Ԛ  \0:Q \  bYd^ g,c yJ̈Z 	Ĭ    5u+s \  \0H \ /f\n  \  p v\ ϫ\ \ \ \ \  \ \  ǝ  ՚\ \ \ \   cL / Z  Ji-\ @LA5!&4 \ 	@Et * Q%@     2\ \  Pj © !q DVblV\ g   1\ \ ka\   z_\ c> \ e\ l \ \ \ \ \ ]= OG \ -_\   -R R (A0    LP1P\0+j\0\" 	@ Gf / U  \ \n\ * H %f( 3j i 6k K Խ a   6 |\ 7 \ \ wGr! e l\ o   Y7 :]y\ g\  | *\ mYD&V T$	!h+ B3B  !\0  D\   \0   >owO Y\ d䎳 \ !  I\ &i =LL ƼUVh  \ =  .   <?O 1   ],\ f d\ y\ ܭ  }:\ _  BAR  lԨ,  qނIDY0  +@  [T@\0 4\" ʋ <    ^qޓZ \ َ\  t\  -Tdˬۧ~NL Nh\ 56
    r\ \  l\\\  \ \ \ ˟  \  p >\ w\'n\ \ qYlT  D , \ Z EP AsT	   \0D\ -K   fa \  x\ \ 2\ \  \ \ 	 % UFɯh  쬭 \ 2IՔK5Ifk 2\ b\  z4)  ?  \ \ Ýs    \  \ Ϩ  :q:  %  NF\\\  s Mdˋ >\ S͞ ~ E  e\ \ FY )  %)  g` v\ q5  \ \ E\ P    \r& S , \ \ x\ \ Œ\ \ !C5 3W\ ;\ j3\ z oF s |}x\ 2mF 1\ |\ \ bY\\ b\ ؞ cgO  ;T      - \  ڱ\ \ y\ \ \ .  \ ^\ z =x t9^_f\ =z{~f\ ^]5 ˙\ u\ ų ,X u \ & ۙ Js2g \ -q < Ҧ,\ Շ]  <t#F Ѯ ٱy E\ e o(\ oY \ \ >  ^YTz  v=~o-~]  \ S  鸾{ q\     u\  V\ .   Ǝ  \ \ F  >~\ O ` \ \ ^\   \   q    ^\ ܏)_O ռ\  z  / \ \ 꾶 R =\ <KM :\ >c\  \ ]9  ^_&z{\  W-  ^gw :jWG   k \ i\ ޮ  \ 6k l $ڍh6\ f - &\ M&\ j  \ \r \ ^ ǡ\ <VoSd\  \ \ \ a\ ؗ \  ~B_O \ ԯ)O d> \ ~t{-   \ \ :   6 ux\ _U\ \ x 8O \ x o[\     < x\ F姂\ ۡ\ \ \ Q |\ \ g:\  ⇀ g a\ \ ˬ \ M s \   \ K\'     3m{ s x>\ ĳ\  \ZU\ { >zi =O  \  庞G\ f<N/ r\ þ s\ qK\ HB \ \   r E\ 6\ ʟI | \ <   D\  r \  l#\  \  m \ d=   { s \ 9n{  \ ޓƚ W C   =  Ϭ{ / }  =\'c@   k\ \ 1x  \ q1 \ 7  c\ j z\' \  1 \   S\"{ݿ \ { ~#	\      =g\ p  /?\  X \ \ /c\ |\ w  \ xH=ͼ,\ \ 3y  ^6շL   \ 黳 \ \ ,J\ 3z8  \   s\\u %\\ \\Sn {[@   c  C=    4i8+sk ҙ 6u2  ­\\  & ּkֳ Ӌ%-] p\ + Y 7-YL\ 1 xю+6 \ X#{R+Y *  \ \ l^p\r\ \ \ \ r$\ {\ \ \  nF\\\ \  \ \ ļ \ = [G   	   z  \ \\9  *e\ 9 F \ & ] h Ɔ \ l\  &Ee  Ð  \ ŋ6 mR W. > \'  +85\ 3\ \ \Z ef 8\ ^ 
u\Zd Q  sֳb vp\ a  9qX\   \ I5  \n\ Ȥ\ o  \ ܧ\ :) ߝˏ\ \ 2\ ͵\ WY  jo 3emTN9 ˋ3:=.OE  q \  y\ N / b  zv\ \ ޞEc   ;\ \ 0[   ڳ8 ncj\ # }<\ \ c;-h ٍrl\ 4\ F \ \ Yt k܈\ KeZ^k\ 3  3 \ \ \ f=7   ϫ \  y \  }   G \ 5 K\ G \  \ 3\  f6|Nϡ\   \ \ 4~  s  \ L > \ <_} | gя  \   S\ >3\    M/ l. [ \ Σ\ x   \ >] \ ^\ \  !\ \ \ \ ~ O\ >\ \ R>   ?9\ x<_T\ \ ̫ >\ | \ RyZ   |\ \  =)  g W 9t \ \ Ͳ} s   7    \ Hk\r ٤}\ i\   =~O   \  \ \  _ \ >    \ wd  \ cg\ \ /\r n{? \ =  f ^\ _\ \ G\ 7< \0P \ \  {\ OS\ \  \ \  <מ;  M+\    z3\  < \   \0 s S\  DZ OK\ \ <..     \ O \ =  ̀ w \ \ >  \ Oco=\ S\  \ M  s\ ^S\ \ [\    Ƕ \ZX\ A\  O  < ̺\Z)Y  Tl\ $gX\ f ^\ \ cd\ j  \ \ \ ` \ +sh X   \  ;\  l>\ \ z  f-ەu \ \ \ \ C\nV63f j  ܜ\ \ =g
0\ kXĸ \ V$VeQ3[ Y$ \ f\ \ U\ \ Z n!0\ #5qW; N  \0 OA \ r iw40k \  f}\ \ \ ?7 \ LL &= 3 ޷\ \ \  S  ; ]  \  \ \'\ 2 q\ ɩ> .\ \Ziģao  \ u6%ٝZ \ k\ g\ Y \Z  3\ ZM    TJ 30ɖ\ n]   d 6 \0،خ  L\  3 A \\RdP`Iz \ ͽ \  A\'  7\ \ ޾!\ 9  \ MMa   \'\ ?-\ \  k  ;z L f\rn*%琑	 	 	 	 	 	 	 	 	 	 	 	 	 3_Oכ 黟S\ |  /\  ; \ {\ ~ \ ~s\ ) _7>\ \'_ \   \ \ \'\ i  _T\ <t \ I\ < ?K\ <   |f\ 4s\ { \ ͝Rg\ \ <, 7T \ \  \ \ > ʟG\ 5^  s ވ\ a  Ǔ{?la \' 9\ ~ 󣝗 \ <k 9(\0\0\0 `J \0\  oA\ \   \0q ]\  >\ \  _ \ O {  z_   \ \ {~!\ \ o   \  \" .u8ٲ  \  <\ ⽧ \  | gc,\ [P \ \ ~o \     /
\ |I W; y  \0o\    \\ O ׮: \ A>   \ r \ }5    > N e    \ ?\ \ <-mP\0\0\0\0\0\0\0\0Z \ t< \ ë\ < :]?4 {  \ w\ \ /D	˄v   (5 	 3Q0 (5 =\ \0 ?   TL\ D YQ(\0\0\0\0\0\0\0\0\0}ݳ m\ \ \Z3 4[\ E 4[\ E 4[\ F7\ +W  \ &\0 D\ \ \ \r&\ ҍѤ\ \Z-\ \ \Z-\ \ \Z-ᡋ 8\   \0e\ \  o\r \ o\r \ o\r \ o\r э \ \ \ a8\ \   \ &A=7? \ >r\ r	f  \ ^\ t * \ ʽ \0 s\ \ s\  N059}\ !@n i =7# n< \   W \ >;G\  \ {o:r\ \ \ @\ \ \\CoS e \0@\ \  \ b >(ƿ < \ \  \ e\ 8]\ @\0 \ \    w \ %\ v8   {o\r\  9\ Z   g \ \ <# \ 6- \ <_\ i u8 #ǢG \ 1    Ks=\ \ n\ 7\   \ m  w G  \ @\ \ ˨v ]~q\ d \\  w \ 2 @\  \0hk ?k\ >y\ )\ L]ns \ <\ \ \ \ \ \  \   \0 \ 嚠u9v; yG\  ؼp\ r$DXcd\\c  e$$!.>\\@\ `̉~D \ L !H\ *  Ȫ«\ $    \    I ȇo /@      \ \0\"\n v5 \0  <v/\  v\ A\ q m\  v\ A\ q n8    \0`o\ q r8  \ ۈ;n \   \ ۈ;n \ `\   \0\'{@v/\  v\ A\ q m\  v\ A\ q n8    \0  \ \07\0\0\0\0\0\0\0! \"01A`2@P345#$%6BF&CD \ \0\0\ hm 6\ m\r  \ Cm  \ \ hm 6\ m\r  \ Cm  \ \ lm 6\ m  \ \ cm  \ \ lm 6\ m  \ \ cm  \ \ hm 6\ m\r \ \ cm  \ \ hm 6\ m\r  \ Cm  \ \ lm 6\ m\r \ \ cm  \ \ lm 6\ m  \ \ Cm  \ \ lm 6\ m  \ \ cm  \ \ lm 6\ m   \ \ `\ A \ ~\ U\ \ <    +{<\   \  _\  [ hy C\   \ \ 3 y\   \  Y%\ \  J\ \ R $  [{\ I\"# y؁^ \   \  \0_ > h}G\  w  /g(\ \ DE\ \ .
\ \ <BKg DD ?g \ DGg \\\ \ \ \ ?g ~\  ǯ   ~\ Q   /g(\ ̈ ^\ U\ \ _ /\ (\ %8   X ,~\ \ oo   \"M \ \ \ iam- e$   = \ ߇3$ H\ \ 낺 ŷ   \ \ ?g ~\   \0_uȿ_\ \ {   wQ oc۬\ {\ 1 \ \ Eobs\ m,\ X   \ s `   t_ǰ  v C!~   7\ Q 
 鸿M c\ +a \ Ƕ  \ \ E n~Ǻ8\ ;X  qq}/\ q~ -\  ~      L`ca \ s\  & \ \ \ \ B\ \  \ p8ׁ\  \  \ S\ \ 篕z/ ;     VӁ\  tw  \ pwEұqɅm \ %\ V11od \ \ )m4ONZ \  =!&c\  \ i  /\ \ \ ,,b\ 1 \ bc   T6\ 0P\ b- :}c \ Ɏ  KWD ڎ  (\ g=   \  1 \  f0H # E 1 ,C b!  Kqź ;\ e_23 * n   ?  rg)\ \ |#;k \ ۣ \ \ \ \ e \   g\  ՟\  U\ C$ \ M\  _\ 8\ y\ 7  1ٟ ہ .-Z\ _  \ Lbz\ _K \ _K }G\ D \0\  rg \ \ a)3\ @%%   HYX  [\  \0\ \ \  \ \\ \ r 踕ގ=tb\ \  )     \ *[p \ \ \ \ :r9ם84  3 _ ̜,L i % Κ\ C)V\   !))K \Zn   d/\ X[ {}\ \"7\ , \ZB tC\"zt\ qrZl4 \ \  9 1Ň\"\ ш  Dw2 \ \ h5 +^AHq p8\ -  D\  J\ \ .2
\ \ ,B\ kaaƪ\ Bِ f`   
 e$[  	4# \  \Zp.8\    \ DE$\ V. \0\ ;  \ Z &	 ɤ/ $n \  ;   c c | \ r9\ c \'G\ 2 L  #!}L\    s   \ _\ ңH\ \ H\ I  oྍֿ  ! % ȁ  - 	\ \   \ L\  7  /   0       ĕ,\ 1  \ \\\\_Ǹ\ P\ C% .\r\   +   )# I!8x7# ې \ d2\ ! $ \ aqpZZ Ŵ=I%s1s! 73H 9`N  J,b .D2-r! \ \ J(dc3   \ z\ \  \ n\ \ \ z(  XrjQu\ n(f  J \ w\ \ 3P\ C!  E\ \\d2\ NC  ?    \ , \  \ [\ Ŭ1Q *\ I\ \ ͆* *1    ڂ[3 \  ]z  k\ b1 S+J \ l8 2$ \ ԫ\ zb1W<RE 
 PS.$[e\ e{ J r8 n$   \ nX\ P\ 0 - \ /\ \ E\ &2xn<c\' w  3?\ \ Tg  LL   b-a RM\ FDM/#$  %-  .R= L6\ M\ x\ Cm!\  hHR\ P.\ o1   R }\ ql   I Df\ MD\ R .\ RPGv n\'\ I  # \ R\\RF\ l 2ӑ\ \ L\ 	\ \ h\ )ef\ P\ q\0   \ ͱ h m \ 63l 6\ 3qM$ cm \ p    ܏}\ \ L  iL9 \ T\ K6F #q    ! хJiI\ \ZvNm \ \ \ $\ 73l\ V\ \ \ \ u\ :\ 714\ K9- [_&  $-\ e7y	7U\ I\ E\ 2!q  d  FD2!  dC\"!r! E\ 2H 
 o [ ס  \ dWA Z qq\ C  \ $ 
 \ p,G )2ex 1Ӏ\ .   ^ ; G  2;t n\ SkӁ  
 
 
\ Y# X $1!b  ;  H v Ux \ $ k4  \ KI* 1  lt \ fuDӊ$  l  : vk \ V˦ C Q \ Co  oE \"\ &^\  6j\ uHR \ \ % \\/  )\ T`v \ \ 8\ d\ u\ \ Ȓ\ 0   F\ /2	
2S/%4%A1\ 4snD# Ur  R \  (  \ l 4 V \ %nHCA[ \ \ H 
e\ %	e\ R  Q _\ QZ \0f Z\ WZm 	 )JB hi\ Om\ \ /:_   ˧ 8\ 1Y    k\ j bk3 !$  {) 6ub[R\ \ n W       \ \ L \0\ \ jb T] DoΈ\ ԡd S(  o\ \  \ v_\ h\ ]1W7 i\ \ j  . ) uԧ \ }  |F \ & Q~\Z!-1 S\ O & \ D O Mv %n  E=kHa  j  \ & >L\ >\ }Vc \ $  EJV\ 5   QV5\ \  \0  I}3\'Jyڭf  2 ~[J J]LS8ԚD\ 36  \ Y3    \  EF\\  ե 2   }\' 7\ M5TW  _\  l\ Hr 6 ) 8? Q \ZEQ]  6C  \ -\ t> Is F ^ \ a0    \0 w   \ C\ %;	 \ .]!R  \ L\ ̎ a       	\ 坾 m4Vn   t \  _  d\ \ 7 Rd \ F I\ ? \ \ #r   O\n \ 0ڕ\n3 =KszE- L C\  I\"  \  ] P; _ \ j _\ R   S \ YM  ).1\"  \ \ \ i KSg\ q  t\ Sk\n :+&D%^ @U  & [\ 8\ ʤ S  \0\ I \ |\ \ \ x |\ \Z >/a  \0 \ R =nM!R   \   ʟ0\ \ 3󘽗 Q=:1lq{ \ \  1 HbC H # \  l   W   	\ <M
\ 8 \ * Ύr c\0i\".L`ౘ JL - \ \  m}\\\ #1rІB\ .C\"i h /3&\\F t  8\ LW\ Jei_ c\ \' и\ ˨   \r   ~  ?\"	 ? !d Sn\ fc#b C 0\ [K\ $d  O H\ \ F\ F	$(  r1   d8\ T3M<݆\ \ \ \ Ċ\ \ r
5\ \  (yx\n  xs#B > \ \ Ё[ \   & \"|d   J(d   J(d    .f,A\\x w\ &iR\ 2 O\ H  \ \ \ \ N \ \n  \ 6 f\\ y_gS,w\ R\ ] s\ \ 
 ~  \' \ \ W\ \  \0  ;    B| }IVN   \ \ \  I  5, \ Oj \ \ .M A # \0^ yR   \" \ T $\ 2\\\ /\'\ \  \ Ý=OE}(>uW&. h]$`  S  \ \ J\ {    HȆC! \ \\\\\\\ \ B\ .b\ 20j\  qς RG:yk{ \ \" \"W \ v\ \"=; 9X. A \0 y\ A_R \ O Η ȆEl ϺC \  \ \ c   X p\ tX 㣍8\ W  a`b\ \ K\ q}2  \rWԼ   \  y\Z| XW E ԡ  p\   \ ^\  	U\ \\/+ ?>n    QrE  8B  G|\ D   y\ =,c  C n  9.8  \ 5\ L  ONt \ ] Qm &\ ZnD\ IKr o  ۨB jF G \ O2Zن t  X8,\ \ J   \ MV     *S  >\ ΰ 	m  R z 
ipwh I]  \ \ M9 _v<f ATx\ S?\  
n 	 Ej<#a $7ʬ\ % R\ \n M 8 3h \ tG}\ \ b ̈.\ !\ Ɂ&  \ S \0}\"e6 K  U\  \ 0 u)sSMv \ ĩ\ n L %h  a \ @Yp\ \ 2 B\'F \ `  \ Mثm\ \  4̒\ dĺ,vdH  ~ ;\ 7[J\ b\n\"\ \ VDi5((  ڒ`=W&;v\   NE1ي  \  j PĨ\ 8 3\nSUXc ?    ( :LIq  l  ӻ\ Ĥo& L LçR   %J\ Sߌ\ F\'\ -\ v>YM     &D* _ Pi1\ |>  TJ \ sQK Zm 4\ 4\" ] \ \" J F,,aدɠ &  \ auJu9 i   \05  v ] \" 5  }C| G \"    v   K J \ O    \ \ \\*\ \ \ U\  J >Kҧ L   W \04 NT  \ ?  \ iu\ZE: a\ .\ I @~< \  j \nd~ڨ?4qt \ \ j <\ 7%>$  \ \ \ n L  \ \ F\ :# j\ \ /˕\r4 V ʗ2 \ \ Ҫ1  2\ 
 R\  \0 #\ \   .U; ŪF~{Rc9\ \ \  \  \0   \ F @ JϿI\  m%  .  \'\ \ QsI J   ß    \     $Բ   )sXzM bc蠉2 G.b  ^iN> \ \ s8\ e	 u \ ky\ u˩!Sf8 :\ A*6\ Y(\ \  $ԥ  D   f pۓ) 5)F㎸74Be
i Q\n S\ mm8  \ J     +u\ [jR F \ZMr帅 &se qm(ԣ58 V  ڴ \  ܩ,  \ h - )o--=! [κ \ pɐ S Z  % 7\ RM\ M	u\ & \ .n8sv\ u v yΒP\ \Z]y )  f \\h\ JI jqJuŒ%\ m\ \ZQ)  qqq  G# \ \ r9 G\"\ \ \ \ \ W3\ }$z y   GΉl\ m EDm 
k\ _>>\r     \r \ *kQ \ Η LVe \ Б\r૤\ :  F\ mE%   {-  | \  MFz   K \Zz  {   ƥC}p&\ Cqi  j \ 7	x\ \Z \ *3 R\ ϕ5)L\ TF]΁1\ m6 9p  \n+i SX   Y   ! T \  \ e ͧ \ YƐ x8 VZ   m9 \ \  u)# =<ǐ i  \ \ q i}/   / i !s  5\ \ \ \ i- 	 \0  w  Eک Xr aP?  \0\ D L % \"I\n   c \0 5)W \ Uz e_\ j hu)\\v OTg \")
7#\ Kd   čăp 8  \ !  \rč\  p \ F\ \rµ\ \ C!  \ \\d2!~  \ # 8鸹
     t\\ \ \ d  u .LP    r\"    \  0̗\ 5 u\ S:2\ ;   \ \ N{\ fK \ n-    r\ 4 \ [kuռ d   1\  \ 6|\ \ JJP \0 2;\"t \' \  \ \ ӝx Pݤ@u # u  \ \" \ %т \ Т\ ¤  .Gs \ Y\ kQjhR4RT M   \  8  L QnA\ ̨ \  \ / ߎ \ {	m\ \ J 	,9 \ Ei      \ \n[ N q    1_  \ I\ \ ۵  6) \ )u֩1  %  _   \ o\ z3   l\ f \ Zq  <F\ \ -#\  3N]Q  QB\n \ \rR#)Y) r]m\ T \ CN: \ \ -   =a  \ H9 qt\ ] [\ \n\ \ \ KM\ aI 2DI\n + *rݍ\nT &  sN a       )f \ Jx J  ƥm  ?   \ \ \ + H        I\ \ )\ ԯ Ԯص)j w Uˣ! \ )\    XNT 뫎\ KT\    ͉Xsi LNy߈HD \ \ \ %\ \  
n|\ \ v 1 \ Cb ]a{\ \ G Pu\ \ \ ؍H +\ Q?\  _ &> * .:< \  \0\ A@nRj2ߗ\'\ 	O!Ɏ) h &   -p\ \ R_a  /be5%wR s%O> $ a5G  8   By    \ \ X G\'\  \r c  \")F   N H}  	 ێ\ \r\ ب O  \ Rlw P*   	T\   /ŉ\0Q&\ i } \\zt\  ⾆$;lU\     cɁ\ \   \ S\ et d\ M  KN  %E  \  R\ ep!@ 8\ &\ * OK \ \rJ   ܉L  \ \ Jbq  s5\ \ ~C  t5v: \' Nn  \"T   l8 rܵ$v\  e)z5!m \   :.z \ s%&[   #  2Z \ S\ p\ \ \ _ \  7?v% (l          $6Hm$l l \ H\ H\ H\ ! Ci#dJ/\0 R \ \ !   Ci#i#d \ \r II))IIII \ Qx (l      $6Hl \ ! Cd \ F\ \r )I$6Hl 6 ֆ\   F@\ \ \ \ j   \ m  RIAE \ \ :b@m\  \ \r߰q7-ZM Y :  X\  cU=\  M\ Vӑ    x[n4\ \ r-H Z .\ Fr t %\  \ K}ڤ i ŏ B 7\ N   }E\ P7\ 7\"  # I4 \r\ r \    Ǣ\n\ \ *	\ 5w\ CJI\ #Fjr UH \"+) \ 	r\Z$  r  =:\'d   ) qHS 
++F\ \ \ D\ % \ \ [Z+\r    ؗ۩ aB b[ O %  aEb W \ W: +,   <H f d L%\nr \ a     \0  \"\" C\ eNf  S\ }ux\ ZS\   [ -\\        \ Q T  ) LM! \0 N \"  H  \    S \ ]/}z LX\  ٶ\ j ۳   \\ \ \     6 v*J  \ \ \  է        *G \ \ jr\n G   i3 q Ju4xmIr\\	    \   o Tx +\\ X \ \ u_*\ <  jI        T  \"  ( Z_ Β\ 댶o Yy*~ \  B(  ٳҺ  wo~  X 9\  G\ \ ~T  ,)   :*I :T   \0\ \n \ \"[ѣ\ ?   R    i\\i[6\  l\": =g\ iBd   l- >\ Օq\ Oy\ M n\'  t =*<KVU\ O &S\ G\n{\ A kV   %  U ښ !j\     \  Ak\   Wڝ 8    \ \ q$  2H\ #$  2H\ #$  2H\ #$  2H\ #4x  j\ .<72H\ #$  2H\ #$  2H\ #$  2H\ #$  3@7  WY<72@\ #$  2H\ #$  2H\ #$  2H\ #$  3H7R W  \ \0)\0\0\0\0\0\0\0\0 0R@!\"12PQp \ \0?\ f=L  槱\ \  ;  \   \ ~\ s/c   \ \ \ g\ w3 ; S?c   \ \ \ \ g\ w3 ;  y y y \ \ \ ~\ s3  \ \ \ \ g\ w_ \ gu \ \ w2; \ \ \ gs3  \ \ Z oؼ\ <K \ oBm|4 )JR   \" /M   \'  _<)x W\ JR /:] ץ)yR H[/%/  \  񯪅 \\W  < \ 
¾\ \ \   O\ \ +\ <  \   ҥ\ - \ p ䷜JR   E\ R \ l\ R \ w  sf]  :^l|  vJ \ \ JR e(  Tnx\ \ v ٔo\   *7?
\ JR e Hnu\ l~\Z2j^	\r  R   \  \ \ zR  \ 6[ؾ v &̾+y\ ,ݓ \  !6C   [\ /&B	   D7w W\ !B ٍ HbD\ b淛   ! o ( .
 \ - Ӆ(\  {B \ s D! ٱ\ \ (% \ {\  !BH  \ 9\ 
 !M $K F? \ ?   D&\ \ 6 !Bq  \ M\ AbJ\ 4 K   ǣ\ h A B !Bp\\!B! \ vH   #S\"!  BxB   A-  m j\ \ ɥv lOxO!Bk .\ X L   ,  q \ \ JR\ < A\"\r \  db\ \Z a  x䆿$!B  \ 8Br \Z!6 .\ L\ \ -\ 1\ 5 \ e !	\  )K\  \ \ n \ N\r !	  \ <:\ K \Z\Zf }#ժ\" jq~C \ !6 \ 22q\ E 4k\ DR  eL ȥ?;\ A \"     ӣ\ \Z\ 0p\ 8\'Ff LfpIc   ŏM]\ ZpZtzPzgL\Z:HB :t \'H  X
D1\ )   @ \ -50   X\ G -G\ je Q YC\'H  B !HRmN	  p  !  3W A\"\ ( :F B !8͠ \\ J!	  BP \ 1mw R% hj8A   jųpy    hB\rM vGT1\ ä\ \ N \ \ k Cth &\ d R\ ɵ)L \'FB\ \ 	 \ B\rm7{ f  \ 8? Bq \ x^ԿJ  )J2 \    \ \ \ \  H    =4b \0\ \ w e\  !	\ xM <	߻  \ ǭ  5 sˠ !\ \ \ \  h -<f   >&\ , _ # 8a    Ws\ c   \  \0  \ =#\ i/   O  \0M \ \ \ \ b  i  \0   9  ں\ \  \0ܿ \ \0)\0\0\0\0\0\0\0\0\0 0!@P\"12AQp \ \0?\ G       h\  \  \  \ \ \  \  \  \  \  \  \  \  \   `q\ q\ q\ q\ q\ q  h\ B\ G    \' O ~;\ ~;\ /\ lK \ ׄ\ Bwo\ N   ߪ    ῴ O\ E   \  6O5/آ 7e\ b_E}f\ Є\' }F\ \  \ oi\   ׳~K /   :?\ ](  Ծj]  xV\ οx\ \ [.˵:캿  {җ \ }  \ \       \   )JR  )J]\ JR  )F\ tFZ k . \ (  J] D\ R   .ԥ.پ\ B \0  D\ Ҕ / \Z \ T{\ 5\ 8ɴ\ |4 \ |H\ Cg  s(] zQ?\r)v] jg 52.\ F    /    \ \ SS\   )w ~hBu - І
\ \ \ xB	uc4׼XN  \ JR  /K\ Y }    Q D\ җjR   \ n8rQ:7\ ƨ \Z\ O#M R   1< =_  z Ԣ\ l +)JR  p \ \ {\ y\ TbP\ \ b\ \ \Z!\"4 \ c\ \  \Z^\  #5LT( JR  )J[ ڔ    e++  \ 8{\ qJR  z_;! x. Eꐼ\r      Ɣ E\  \'D$B- \ jR  } \ zY寋0S
<CD)v \ Bv CWK \ ; ƞ>\ \ {Ҕ .\ \ vL \ v \ K zR  ޗ{\ x ֛\  !< \ Vg\ \ \ \ \ \ ]i| )JR    5t W\' \    ݏ\ ì\ JR  R =< \ \ \   ML2Qc t ަq }0  \  1\ \ o\' r\  / \ c  jz_W \ iɫ \  ~\  \0\ \ R|1\\    N \ \Z xő     ħ \  \ \0I\0 \0\0!12A \"3Qa 0BR`q #@Prs Cb t  \ \ $45S  c   \   \ \0\0?\ o \ o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 -\  -\  .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 .;K o \ \ \ 6 -\  -\  .;K o \ \ \ 6 -\  .;Kq Kq Kq Kq Kq Kq Kq Kq K o \ \ \ 6 .;Kq K&7\ %ٷ\ \   \ \Z  )    { z  B _ \ tU?O +Ç\ \    C ~ ӏ\    \ \  ѽ \0    \ \  \0?  \ k     \  B \  \ \   W\ \ \   \ \  !o\' |!h  \    \ \ , \0o|! |\ \  \ \'{   *\  y  8  \  ?Z+ ˀ  \   \0_ ?  \0/  @ n ?\ | Z\  ; |\    3^\'\ \n O \ n \0\    \0c   \ \  ~Y  G   \   \ M]\   \ \\w \ x|R :  Q   \ r\n\  ~ W=  O\ . \  C ?  \0o ?     :t\ \Zq?\ ,    \0\ +-8|h׏      \Z \ / \ 5Y|\   x-~   \ \ q C=~ \ \ :9  o  9*   w \ \ }V L\ \ Eqp \0_\  Z}\ \   \0_\ 5Z  9 Zt    Jӛ    퇒\ \ \ \ i V{  5^\ / 귿 \ \  I Qt\    Y ?\Z\ h Z-=O \ W8g + jz%\ ]B7  Q Ygq\ M   )\    9~# \ \ k\  N?\  \ Ey׀ E\ u}M\ N-]  ] \ C   7Tq \0\ s   >\\\ ת7~^  \Zq , \    ѼO  ;p  ~ \ (W  \0E ˜ a\ C N ҙ \ \ k\ j    \ Ĭ \   uf mJ4e ƙ, <?\ k\ ӊ\ td\ |  \ TD\ \ h4\ Ӥ\ x Soe\ p  \0 9dj  ס Ex~;A  ;JuN  \ j    ¥sYg \ 4\ Yz QQLռZr \"Na<\ $:[\ +7T \ ߳\    N| [ x. \ \ e  z \ ku[I\rO W ܘ\ ꖏ \nqh\ \ 4ՒעVD\ .) 6  o Y \ 6Ee\ \ O_{wO\    :BjF  d U \ V^ \ A \ C>my\ \ZS V 0 \ \ Q  \ w   U \ j  -  .   \ \   V ٭    >mV . \ ^?    1\ \r
OU r˛_Ps\ q24S  K_ n   \ B J \ ]\ ] \ C  \ i  \ q+t sI mx/ \ -\  =\ Pʁf =  h   P\ j % jڮ k3 7 \ ]p+Z-\ J ѵM\ #Ɗ + ӂ\ [ qf\ ]Q M\ XV ^fׂ{h\ ;ß#ͯ>  & \ k\ }S :\ B 5  G\ uY  \ ds_ \0 \ry\ @  ͎ \ j   f{V . \ v \ \  o9o=\n5\ F <\ ށ,}x  ~Z-i\ \  L6  ^<Wz4M\ R ܙ \  i\ S>] K6 A\ \ \ g෼\  K-UC ]g  \Zǚɠ| \Z j s   B Z!Sw \ ZYop+y ) {h \ \ j=f     \           ?US;k  s \ Tz\ [\ \ :  2O\ ۖ >͗ 3N. V VR \ v ] |\ h\ 5  ]Y \ F Ѿk} 
\ \ &`\ 	\ hվվվ\ 5 \ 5\  \ 3f \   [\  C \ /9\r4C5Y\  \n#d\ x[\ yo5     mʍz 7 \ ;  \  \0dz\ \ o ූ   V \rV U \ j   U \ v  xz   ]    ::t \  \\ J\ \ w \ 귖   KcE\\M;Ӛ\ G > E \ h \ \ ͧOE Ӟ(G s (f\ Sd   K \ N \" 
\ |\ZV\Z    ŢC 2Y\ \ \ \ #\ l) k  \ ?   \0\ \ ن1z\ >\ m q> 
 {   -ʪ9\ 
\ s _*3\  \'\  cs]\  _i\  m\ T\ {\\\ Z) \ 	  \ W\ o}   K	 9Fa   \  \ \ s x-\ \Z5Ǿ   O      \   \\s ErV
\ \   d \ Tdsm\ ٍZ\ \ >
j\ N8iX\ \ \ ̿Ƥ  9\ 2@ \0ܕ    ֚s\ ڟ\ \ D ~`B 1\ xfq \ W[J\ \ \ \ eT_  \ \ h \ 0\ \ ć^\ 2\ }U\Z\ 6 6  4 O1a\  \n :<4  \ \ Ik_F w  \ N  R  \'H}  \   \ d  Җ \ns\ q\ 7k  м \ 9 Ud \ - $1\ j 0 \  \ Es!yo M9     ( \0҉  ?a\ 8)  \ \ ѹs5 \  \ \ v\ - \0\ ;gu \ \ \ h K  * i \ $l \    V7
u˧ \ \ ͍\ Ʊ\ G \ 7\ c$\'e \'(\  \ nΙQ1 \   \  27\ C ok\r\ a\ # ]   Idq\ \ \ %\ \ >\ U\\  J  Z\ (a.j䏪\ \ 
\ @ \rTX\ A\ ]`}(ŉ}  \ JuV=\ ct`Z{ >I:\ 0\ ׊    y    ^ ?\ 9bq-  #  n- @ \ N  \Z3 ( ,  CB\ 	 B\ q \ \ \ xnrCq@\ )m\ N\ \ \ mi ` t \ L K\  \ Z\ x&A< h \ W+\ 3k c\ 9m 202k\ \ S7\r  \   \ X    :3L×(\ [] N\ \ $\ 1ѕ ζƣc\ \ 8\ \ 
\  \rySb$Ͱ\ \\L RZ \ fFK lX  \"ѯY \ d ձ\ E  >\ ki\ \ Z % 6 \  .\ s*	 J\ \'\ 8 N*\\>\"M \ ;?ib 1\ $  X  \ 2 $i x.X  \ @Sa\ I|r4 J-  D\ \ #*#h \ X?\  + %e >\ pmV\ GUŎ@ \ \ \    }\ \ \ gfִ,<6 y  M \'\ \  jW\'b_\ B{\ \r 69̽\ X Hj\ ]\ \ =\  ¼ \ t f \ MX  \ b[Qa \ j     \  \ 豴 \0 V\n  `  \Z\ &\'<F	z\ n Olo\r \ +?\   \ \ 昛 y HϽ` \0@({ ˕s \n
 p\ sD n\ r R\ \ i \ ~t\ \  ,G\  \ K% a   &|[Y % \\ \ \ < Ⱏ b \0:\ ~ L \n \ 9 \"\ q\\ B 7 \  _a.  =鸌\\  6\ ո V  mc+n *\ 1 ҷ\' \ G(d\  \ ҡM   G0ѷ.Vi֨W/ + * \ \ cs \"|3e\ -  Yg Bǂv   \" \ V\ =P \ A-\ \ ?V KN\ p V xR\ !K \ = KKX j W<˪ Z r  ԬN\nIvfL\ \ ] \ 6( \ \ W\ r Z ^* X \     \0,\ X\ 1|4  \ o 7Z\  _ \ 8ͭ  \ \ % \ I\ \ \ X,/ Bj\  Ϩ\ ɣ \ 
$27ml{h  Z\ \ ]nv\ \ \ h |\ Uo -)ϯCU\ +& §6 \ s\ >B    I \ \   s\ \ 2 \ \ \ j  r\ Y   Z fզ]\r\ +=SW\ h   } Ǜ%  J \ \ n \ ^    \Z\ #   9 \ \  
6 ˗\ ָ\"҅8 \ י\ $h9 \ \ Տ   m A = &=ѓ |­  -\ E Ӛ \ \ = PW$\ w^  +S\ \ \r \ 8 =3\ ~\\\ % \ h V D}fkO 5 \ I  \ \ kBh X \ Cp \ U n1  F\ \ J(dk62ee4X   ך! k{\ m  jl m<u u^ }H\  M t Iˊ\  @S\ \0 S\ aHɳj\ ?]r \ ,\ X\ \ \ F3y\ \ @$W:\"\ b #Z,    ӝ \ y j  m -P ןE \ h [ un պ V\ \ [ w =VNp eϑ C\ \ + \ !h  2: 3 g   3  \ ͚\ x\'g\ \ e돭\ 7\r:\Z f С v ) 8 > \ ! (S s\ns\ \ }F %  [\ U \ \ ͧ  \ 7\ \ \ <\ \ \ 7\ w\'5 \0\ \ \  Ҽ\ v  k  1 Q r\ \  sI5
 (\Z A\  \0h  ? ;ӄr\ \\ \ \ k\ P  4梻ϞI$LC c=\ V\ O.:6\ ~  `  e\  H\ J 6 t& -.͓wm|   9  f]d 7w6 \ \\S  \'(Y ԕ<xW Y8c  \ 4\ \   ɟ \ \ ͇ b\ \ q\  4,C_   5\ ʩ\ \ d- *  \\  ; \ 5c1   \0ɾ*( 85\ \ ՋM  u>\"V^\ [[=\ ɭl/\ Q ڹV)X b 
&\n \0 v,[8\ Cp rc m  0\ Ճ @  \ X ~C\ + Ƴ3F i  (  XָT       ӹz.#\ s R\ \ \  d`\ Xm #3 g\nvŬ  ]j\ H\ Z D \ \ \ \\ #  6f  \ \Z a &\ >#K  { \ 	[ Z \ 	c:\ #k ע\ 0\ Q  h r˱\nF ,  &a$ A   tSG\  K `yk*\ %:S 4D}\ \ Z K 0  +$  \ \ +m\ (\ \ =\  BtP\  Ђڒ \ \ \ l\ }*  \ a! < skr\ \ \" 0>  E\ \ \0}W a0\ Q \ {n.X9   <  c@ \ 4c4
  .ux,3# 7bde\ { h  d\  fl\ \ u \  E#t VG UG;CcăG  B\  Z`     Lp̑ 6\ 1 Ce   `   _  \ \   - 	\r\ a-sZ \\T 8s.# M Z c ;> \ ~\ \ \ \ 
_c  v|,! c kiE k D9  ޅ \ \ m\ bbn ~JP  \r \ E  (v.u ۚ~\r  \ \ ^+r \ \" 3mKB >L ^\0\ \ Ԓ  \ κ \ r   e\ 4\ \ \  \'2\ \ \ 9}Q.\ <\0\nL?] ^\ + Ķ\ c 6 J  \ \ w+ p5\ 6UE, 5 \ X \ VK  F\ \'x L 7 \ \ r { v\ \ \ \   ,     V NC wS   4nҦ\ {  1 \    b  
\ 6\ ~\ \ ` \0   \0]`dË\  \ \ L\ \ ofM\  \ :\ a s8 Pt̲   U&  o\  \ \ qQ b : ,\ .\ \ \ J  \0\   W)&\ \ \ X U  \ C~\ U \ \ FN\ \ 95 @CA\ <\ \ Bc=F  \  c   ѡ  & #,r    &\'o4\Z %>\  N\ a 3E7Xf  KYw g  #	 7\ \  J \ \ &   ³i v= PV0\ - \ c8 7\ T\ + |m  Q:W\ w ˸x N   M e(  բ\ \ \ \   \\$} r^\   - l ] ?5 8O ˾  )݌{\ 4k\ k \ ?M\ I\     \ r\ ~  \ /\ # M\   Φ\ rx \ = 7 W% X^\ ]N;Y   \  DT q ʺ79 \ i   9\  cTc\ :\ \ \ \ U r9 \ N\ Dؓ
  n C \ V\ #\ \ \ \\  \ \ Ue    
{ \   m\ :\Z \ 8 \ B5FG    {\ \   \ZU{ x\ 7\ \ \ \ \ h   ]w \ {F  N  * SĜ\ \ \ \ wW5  \ Wv  \ 9G\  \ \\mX  3\ 18 H΁X C\  U\ \ 
  T\ ܍@\n\ 8 8 Tm &! \ q⍒Q sC  \"\ j|P \  +$\ \ \  /
fq2[\ vH9 -w $ \ t q\ :\ \ 9q  \ s #谸l;  R\ x  0w5\    \ f\"@\ \ \ \ 	h\  \ W3 \ 综  \ \ Wv s \ g\ \ \\  \  \")\  u   L\    NUMa   F\ $\ \ 5\  eT \ } 3  SO \ \ \' \ \ \ ]\ tosᒼ\ d  \  + v E 1\  ТY+ #:\Z+ \ 5E\ q\' sF\ \ \ h   Qs\ s  ̦\ #  UY\"F  9\\Y\ \ \ \ ;\ ӫC  \ B g \ wO?Ĝ\ L E Ӽd ik   \ \ }F;j;8 \ \ ; s \ \  |\    ! Z ǽ!\  }\ Jf!  \ t \ i_ lؙ \ П0 81 \  JD\ 6i\ ͍~ 
Y l8 [wSG\ N#D\ S\ qP 8\ c  x K.  \ TP\ ɱ3> o X  @$v  \ \nÇmH\ +c>( ; nE  u\ \ 8  66\   >\  g = s\ \n\ >   { S0 ٱl m   \Z,
% } \  PI
md̺\ \ a&  S 3i# qvf 	    j\ \ \ 8gi\ \  \ \ \ \  7\'bbm  \  j R  э#7,\ \ , \rB\ \ &ak6V  IR \0xX \0\ \ r    \ \  \\\Z\ ֨X\ \ \ K;Is|h ;73\ .5r C \ \ XΤ  \\  d \  Z   ro\ & k |  Qo  7Fӓ   5 诙\ Gj\  \" 㱔  \ h  -9 Z-9 Z-) = - }Q\ \ \ W < };\ 0J\ W \r \ }4 \ mNʵ  v\ B˅\r;  3\ \ \ \ r   \ \ X 6  \ T\  \ % 5\ p\ [&-\ j~\ G2 GS M{k  
n%v\ \ O{&s\\ \ ޚ : iȧ>G 9ڒ $   Fׇ36n kT\ 88\  Ed\ *F v \ \ kgph\ ]    W \ o \ ~J\ \ w k [\ Wo J\ \ o F\ z ׇ8\ \ HF\ \ O h    j:Ań \  \ \ @נڴ \ \ \ i>pK\r\ \ v\ y   \ W     V    \ T \0   91 h\"\ j   \ \ W*< 4 Xƒ\ \   \ \    3g 8 }+ z  \ +  \ \ Z\  VM \ B״9 ~ %#?    q 
<    w&\ \ ك\ \ \' \ \ J 0 lі\Z8     \ L ё Oz At  6W+O ,   \Z \ \ x Ŏ G \ $L  \ \ 2^  \  \ 
 \ }\    ! \ \ n  .u\  /Hİ;\'e\  Nqԭ \"% [Q޶ a\ \Z \ \ s  &݆vf \ 이 6 b = [N ry\ \ ̬\" 7 \n8 ŵwT\ g 4\ %\  כ AG;\ \"7 Q\". \r  h \ + `=jd q0 \ )8\0 \ \" !    y? :kz  \ \ZTL \ Xu9 5 εL懲 by7\ \  >\ ,\  \ \'\  vޕ\\ \ \\\ 9\ \   ֐ #\ \ 1Nװ  8  ez \'\ MT\' \ K 1\  \ e \ 	. F   - P?  \n ߳mm\\ ]+e} \ G  \ l   \ e \ m \ Ú \ \\  7\  }  \02 \ \"3\Z)\ \ \ qX pϠ  S%\ \ s nS!f X<,y=  ټ\ S\ a \ \ ậV7}\ \ QA   \ x  I +cz \ zP} ͛\ \ ͍ 3GmuX  !s]
 y T\ 7~6uJÍ  \  ux G\ z  \ 7H L\'\ r~\'Z\ \ {\ \ r Wub  \  \0  rd \Z 87=\ \'   P\ uAZ͓M I! \ R*T-t\ a \ BM ).Ķ{%  \'a\ u F^ qSa%n\ ;68 ߼  \Z\ V  A &  9\0 \ e 9  Q[@]ދ \ ޲\ 	 J \ Z\ \ { \ l G\ N#[ -  tA \ \ Ս\ \ t  \   M \ G    \ \ \nC+\  \ r   \ uj I^\Z\   \' ܱ\ tX\\.\Z (= \ G  \ d&\ 9 \ P᧻d : dv- |C[k Ч` \ m_# +Ɯ\ Épk  \ \ 	  \  \ C\ T\ W  \Z\ f[\ , \  \  < \ \ G~6KnO   Ẕ tL\ a R\  S\ 轜   Z .6H\    w)08\ }  ]\  6@     b\ 2\r  5H\ dn\ \ 5  \ \ -.\ Xwh6SQ   y_  p(\ yR3kA  $N vM ,<Sb  \ \  O8 < 9\ ѡ6 k   y )\ y\  GÁQc\Z         Bђ\ B$A-Kx N5 K-!\   \ \ \ \  (0 N   \ hB|l   C   G޺م UC \" 8t  [A
b\ kt ˌ q+(Z 2\ 0 \  \ \ \ \ yƧ\ 強  \ o \ o-V U    U   N yo-\ V \ Z V yo-V yo-強  \ ,ܷ  U \ j Z V \ j [\ U \   \ ǥ \ \ ~ wE؉ [\ e\\Տp   \ B>\ \ ЯDK4      \0  \ W Z\" \ l ;I \ \ \r 6Ƨ\  \ \ \ >\ :\Z  ~  \ C r] ^Z\rsச\ \ Ù Ǽ\ & Ķw\ 7Թ\ \  \'  
] 6# \  8 \ \ !qG4 @ uc \  T\ \'\ \ h}٩  t\  [i\ \ m=\ ,Llm\Z\ P @  GH* h\ \ \ Ϗ\ \ \ w: #  \ T{Au  O5,^   0   f &   u  8[\ \ jo\ HƑ :\ ? @ \ P  R@\rhz T\ \ g ٖF H\ 2Ɠ { wD󎝐\ wy\ >   \ $t\ra\    \ 0u \0s 9 mӘM% \ / ;?  \ C$ǩ   |>\ y   \ \ \ bٖ: Č  ]  q \ aD ]\ =3\ : ;-    X  do  \ j3N  o9r W  W ߘ\  \0  (G ;\  \  PI \ \ E- Z Z\ >}\ Rw Rs 8w  \  \ ɚ 1rv\ 	 \'w o\   \ \ ~ V3  ό \ \'7  \'\ \' \ ̶6 7 k͈Ŝ  \ \ Z(	  oq 6\ \ 4_   Z)    ~\ \ ? \ χ\ gmm\ > t   \ %z&   , q_D\ kur   X_I  S:{ <̄{G? ,gg
vmX\'\ \ \ ,- \ %r _#L u MmN , f   .[ F S   \ q{o\  t\ \ <\ 8 \ \ \ ͳ売\ qn,2\r \ W :I10z\ v\ n\ Z FY m \ & +i$ x
 O w
\\\ \ r\ 5 b! v \ \ \ \ \ \ ꊎ\n\ \ s =P   ٱ Zt8 t\Z\ si   $sq.ߍ\ \ F\ m\ w >k    SC  m< >N \ \ <    i | b!$ \0:\ Ƿ  \ ;Ɗ<<]     ޣ N\ (8\ !\ \ TY 2\ 5 a\' g&n д &\ \ B\  \ . (N W l\ <^ 1 \ 1?  \ r   
:  \ ε \  \ 4\ \ s u\ \ \ j6  8 3\ \ \ \ K E\ Xg\ j릓  \'|    t\ =9 qb\ G5   ] \ ʹsi\ \ ]/#  \ k\ \  \0ڙ mdq 1 \ \ \ - 6 Aͦ^ ގIU 4\ 0 \ A\\ \  \ h 
N  L -\ bZ \ =N\ IuMs  v@u\ 3N{\ W ϣ  ?   \ % [\ x-ෂ\ 
x-ෂ\ 
x-ෂ\ 
x-ෂ\ 
yd}<\ \ [\ x-ෂ\ 
x-ෂ\ 
x-ෂ\ 
x-ෂ\ Y O0 [\ x-ෂ\ 
x-ෂ\ 
x-ෂ\ 
x-ෂ\ Yg  \ \0+\0\0\0\0\0!1Q Aa0q @     \ \  P` \ \0\0?! < <  ?\ σσ\   ?\ \       \ ϋϋϋύύύϋϋϏϏϏύϋϋ\   \ ύ\               \\ \\                      \ Ϗωύυϋϋύ\  \      \                          \ \ ςύς\ \ Cu ~  \ C  \ u  \ \ :\ O \  \0W   Pҝq \ ^ \ R z. \ eJ П;\'  \0\  \0_ \ D K  t\\ r\ \ \Z W\ R   u  R\  :!Am\   ߻ ~  + %J֥J *T R zW~ G֩R  \\ r\ J j  sg   . \   :+E \ ]5*W  \ T R \ \\\ 6W\ \ x  ?  C:8   =d k\ \ - ; *\ Ã\ jV \ HҺ+  J *W\ (f \ Z\   {c\  f`z  w L *  %C2 *\ \ ǥ^  ~   3=VX  ϷC  \ \'Uz  1ҷ3G/\ \0Q[t  Wѧ c  7\  jߺ `0t     +  :ֽT A Z  \ \ G(,_\   ;  tWK  &=* + \ _H\  o \ r     J\ Z> ˗ B J *m J \ R  H6, \ r  =,   H *> J   J \ ^ \ \ s| \ \   ŗ/зJ \'  *T ]5 7/\ B   >\ g ^ (  t  \\ r\ \   +ӽ\ \ ߱
 ×E   }{\ %\Z   D Q ˄ Q( J%CGS\    \ Z\ \ ˖Z\ \  3:  N\ bc\   zB\ q\ \  ǈ /\   Q   V  泋\  M \ \n8 =7ը}k R  RU  \0\ \0\ ޣ   eâ   J *W  PWܰ\r  \    \r/    e /J\ p ^\ u \\ I ._ r\ ˃.\\X> \  ]U*V \  +\ j yy| g   z  ~   / \Z=f}*\ Mt_A 6V  o-\ \  \ iۤ\    ˗ 5\ hi\  \0 ych\ c ǿ\ \ \ \ ]i+ 33: \ t\ S@\ \ \ \ \ \ \ \ C\ R  ;v= / \ t^ =\ Mt\' 5,  J +S\ >  \ \ Y|sU\ Ώ ޵*cD  \ ˋ.\ZA +J \ }A  ~پk\ /   \ ]]̩Z\\ .\\ r\ \ B \ z + .T R uW@;K N^\\C :  \ f .^ .  K\ \ \ \ M뼩R 鲥J\ \  \  \  \n\  Z   \ ˏJuۧg    .5 r   /Z\ x >+\  َ \ gUJ\ ֥J *W] gA j  38! @!\     \ \ \ C\ \\  *T d R  (  }vѐe  ! u N\ ҕӞ     +x  \ \ 4 }x6%   ٵ\ yu   \\%C  Y \ Δ@  z\ \ \r)f<  	_\'\'       龰\ f  ם)  *T\ % 3*T L 2 C    \ \    \Z \ gQT	R t> 
B*à    7|  \ W\ w g~ WGCTfP+D \ \Zw\  *T\r  ^ G   y ^߹ \nҥiZ  CGS  4hA  \  J\ \ T:*T  \    s\ 9Nz3+  kW  z[\ Z\ 3\r	rצ }\ z\ e  x f
V  m \ +үQz+\ 	F *A]踗\ Nv  \ V6\\9r\ \ J \ R    pe D j  jT N  \ * x~ E  _ O_: Ε*T V +\ [ h0 |x<,}[} ֢\Z S2 @ E \   ;  ?  X@0Pz }ZX	 B\ ˗.@  Y `  kr H \ ( :0\ zK4%  *T>   ҍ	S S{ݿ\   \   zh eV*S) \\ =?y t p6    _0\0w{_/ \06 $\  r\ \ .\\WUZ	,ѹL$	H ya  /u\ \ d Y \ ަ_]Ff*V  r \ #/\\˗-\ p ] 05 ^ b \  \  ϻF\\Yd ,]7 oK\ $ Z\ IQLG[LK .[\ ,W  \ ^  %@ 8\ d)ygxb,s ) \  O\ = \  @A:T  \ # ˗ X:۠ 330\  9`K\ m\ BQ*T ^  /[\ \ FRAu- ˙\ U .Y t4 \    ^%@   \ \   * n \  \0\  \n\"D\ Q\\ \ UʈD h\ b2 @`Aq\ \r pJ >\ gD7pwb  \0  к>  ( oE \ [-\ ejB TJ%   \ ; o      Z  \ \ x Ď   \ :.Y- 	\ .  B{*n\  a+\ };\ =\'\ uƸ  \ \  = os#., $T\Zc˚O8W \ g UP   ] \0s  =    \ zq.. ՉQ 1 r ]V^ L$ \  \ _)g2\ b  e  W r\  .] \ E\ \ \ }/ 幸  \ !\   \ e:   \ ~e˖  \ k؀\ Tr   -\ K \ K /K  u:= \ 8\  z  / \ ˗/[   -\ yt3Η t\" \\g / 3\ X[ T\Z  \ ]\ZžWi\ \   B\  \0\ \  \ \  ܊\ t r\ ˗.\\  \  T [/ \  K/ҢT  .\\ \  F u \  9`  \\ A]\ x\ \ \   D &\ S V &\ 谥U\ \ \ s   pr   B /A  t   \ =.  iL  O ΐ \ | \  \          @\ k Y\ Cf8 oucw  X p{ÙZa\ O  \  \ \ Z*&    } \  \0 \ G <  c\ w R\ ؗ\ C \ \ < ,\   g- ǁ+ j   \ H \ pE ўe/v j   ;T 
 7\ ܂rR J   ]˗/ \Z:+-\ 5 [\ l   \ Rʈ  \  ծ\ \ ? QF\n R\   <!u]V\Z\ , 4M\ = N \ u$ FT  Nޕ . \ P W    5   `\ G \0ٱu m \ ۪  _\ :..   j 2   v \  \  f5   2\  ˗,Ћ    \n0\n\rh< ]\ ˖i \nո\'   C\ \r \0\ c \ rŪ\    /K.,^ \ }c    ƀv  E \ ̤  \ q\ !J\0QA ˅}   \0%)f\ h\ g\ \ i y~\ \ ɩ \ 3\ \ \ uYr\ \ \ }:  \  Lˋ y .!Z/ĳ n\' fe\ v  \  (\0\ \ 30e  \ :/ 2ɼ\"% D\ Q    0\ Z D ֧  e  Ζˌ      Mj˗\ \ \ J<J 332   dD \ n
  \0m=\ \ ,\ n} J%l Gw \  \ \nR[m\   9  \ q F\ Xڌ 1 Q\ \n nB ZW ~ \ ~ \ \  \ J\"8   $̶+-   X l D K@ ҍ.,%b\ \ e\ \ ~ҍ \ \ p\n \n \\\ A  Z̥\ \Z\\ й\  7\ \ \ R\ AazV^  \ \  \0\ 	`\0    \\\ H\ v ڥW \'ߴPV E FX 3x \ H\ r\ 3ϼ\  O  1    /\ \ V6\ \  { \Z\ GFQ \  h  Eo \ 1 \ T\0K!;\ \\W] \ \ \ ~\ |\ \"/ t BP  \ r   b+ Q\ C\  i}v V +\ ^ \ G\ \'Q(B=   _ \ `\ R[.\\ p(s fqh \      \ a G. 1,\ f NgyZT Q%J%	\  O\ %0 Řs\  \ }7\"/W*b\   8 \ WWW	O\Z\ z._ \ ֻ  r\   D=\   \ VpևBX\ ZZWKՍn. ]֋   K4\ Ĺzdb\ Vُ7\ 5\ \"	 \  %˗)̸ \ j\  % t\n {  l  Oxa l\ l\  { y\ z= נ  1\ d :\\ z]\ _ .\ *\ S  v  x_h \ $ \ 
 R\rv \ ;D \   ` \ a s\ )  0\ tc VK%붶J U\ 2\ \ `˗.\\ rƯ   }  	  GF ޚۅ| UM 6\ \ ˃ \ p    \\ qz./B _[  \ b x E2\ ZV  xo\  0\n O\ \ N\ \0 x g \ Y.^  ҜL + c A-{J&9 } yov\r$j\ Ҙ 0Xn (<EZ \ हz\\ \\z \ \ q\ 1\ G\Z~y\ \  ~  a\ h  1wQ\ \ JL   P  t  S eJ  ~ƘF W0+$- \ \ ]\0v ; \ K . #3؇  1  \"7m  c\ i~\' _=
 \  N\  cYk 6  \ Yio2\ p܇    9   qu̹ee \ v × \ M\ . Ᏺ<   O \ \ \ {ۂ\  ,{ ;\ 7 w}  \ {\ v{\ 7 \\ 9  ۵ \ %  S\ 1 b\ h (\ v\ y+ F \     k  _k \ \ \ a\0 3^Ҙ f!v\ \ P\ T\ \Z\ k\ 9 ,v2 \       2 \ r\r(\ \  LN
I <0 -  vY \0 \n9D+t o p u\ ,8 \ F  s     Bſhv\r \ ҧk;@ \08\   쁲 /m\ r\ \ \ rb`\rh6*v V6  D^dw\n` yGt  \ 0G\ ]w \ \ d \ \ *B o\ \ )l\ \ \0\ j\ Yl  켐M\  I 69e
;\ r´N\   \  \0  \ \ Wۉ ؕܖOym  X7 -\Z^w\ R\ so ^]\ 6\ \ \ 0 { P\ \ fD ?1!  \  B  N\ k/ \ o |W8 L3  .V\   \ DZ  \  Qi^Q W, rj  3&\ v2\ \ a v=  \ G
H`+ %7\ \ U  Y W  \\^\ g5+^ i e  * \ \ ! 4  J \ 3=  ds囀  \ \ 4~  3   #\ /  )\ ,\ \ \  %\ \ I   \  \ -w` \ -ى  0\ \ ;B , z  ̢ >X NC   \ [>@ (C\ Gr?\ \  /  \0@  \0  ȿ \ \ `
\n\  . \ -  | / K\n  \ \ E I  R R Z\ \    _Îmߒo< \ < Y \0`	\   Ks  E\ r/Oh\ G r|z|! \0B[ Q7\ V\n| = \ S٭
&>\ 2 1r=\ ݮLB\'\  Y x S    U\ w\ \ q\     x 3  \ 4 \ 29 W S\ \ < \ x\ ĞRyt (\ \ x \  \  aÏK\ \  Y\   \ \0 w\0 \ 4  [\ iK(\ \ Q  &\  C\ \ /\ 5 lkXn>\ N  lK  R>  |@B \ g \' 8	H { \ %v ,G .a (Cv  w<    =\ e\ @\" \ \ Ia ,h a Q S / yH>Ép \0;\   \ U\ ob\  \"\'b\' W       57ccI\ hQ\ \'\ W + HW$ H LlK1g zʑX  \ 6 b k	De   Έ\ -F f\  #! E\ *    \ ^E.I \ \ J Z<%B \ ߆ \ J\ PJb   jp  \ \ q KE y \ d  H\rE \ 	^\  G$\ D> ݅6$CC   \ m  눍T\ ~\ \ \ \ \ \ \r \ \ 5̰\ ,  46  [(h  _p\r\ ݂;@  c$ m6D  wC \ ET ; L\ P\ @X	\\  ċ  \" E  *\ 񍅉$    F` `\ \ \ \ \ I\  \'8\ X\ nX \ 4 6h7Xa e 9\ T \ \'PC m\ Fs ƒY8Fa \ o\ ݑf\  fe\ ,22  ALC j&;\ * [  r eᙙ\ x  (h\ m \\w\"_0:&\ I  ? \   \ x  \ ?ҋB TD  bėV \ D  옜  K \ \"_ ޕ\Z     Q~:^r)   !IL -X   \0  aAEdn\ 9\ 8L\ dHT6  ہr   [\ U\r(@ \ oīR v \ v	  F\ \ \ {ߛ \ 	xF%\  D \"\ c    bU\ j  @\ G  &J ݓ\ 6\  qk   
  \ \ 	 \ h Q &^ Y 8e \ j   RЦ}  { ƽ $ ߂Lb\  Ԣ⼢dm  =dÿF\  Y\ @  s  \ \ Q\ \ s*{y wh  \np\ `  \ %B \0 PXB  8 v ! \r * 3.3\ d#3  \ iA( Z[F7QP \ \\v i \ 	\0d\\  ,) \ \ K ˨\ \"
  \ ½ \ @ \ \  ga m\ \   E\ \ p   \0`2  e ㍣\ %M 
 ` \ \ &CSz W Y \ E \ +- \ \ rŀ $\ y TL 4 \ \" \ 7  W\ مԓ?˙ RA   f \ ka  \0\  4- u* *M p  RLq  M x;3-   l  K \Z%g.  p\  \   H-Jܳ\0\ c ,5\ \ \r  \ s0.\ R\ \ \ y; \0\  6  ޞݢ\ d|J  ? 8\r \  u^  b  \0Q  e  .  8 Q 7P 8 x;\ 8n(eU 	 G \ bw\"% \ \  \ \ JAm s  \ \ V\ @d *\  E7c/of*ـ>Ұ\ ؝d\ \ 5͢    \ R\"v?   \ ~ {\ \ ,7P\r@;\ \\\    ^e=\ *enʊ   ݮ\ \nv%\ b\n * \ Ir\ Ob >aO \ \    /C \ZE2^:.W&Q \ \ \ .[ &\\ž     \ \ , gG0\ 7s   .\  t Cw1  O\  \ ],  E \ ^ 2 V} /\ i /\ g  t\ ǖ 2 [\ \ i yd \ !  \ \ l  y \Z9   SiX    0\ d\ \ \ Oz{ g eK \ ̢̄ \0\ = 2\nﭲ    ǈ  g	   \ 4ȶۏ\ 
 \ i\  b\ c  t6 \ \ E   j!  :b m [  o    s ,U  1 dA K \ 	y1w    }  \"\ Z  \ q\\۴kX \ \  ;  \ o*\ Ws.   p h\ ޽\ \ j{Z\  \ 6  B \0]B[  E\'\ ˕\ b  \ {xBTj \  7Pw+c- \ Ak >#\ 0Od_ Q\ Q/#\\Ѻ\ ^ g  7n +    \03[A\  C7\ B2  #\ Gq\ \ I       Ȝ3fP5   w   ߱\ O\ `x  x m\ \ \   $V\ *Q*) \ \   Q( D% G\Z``{JNڦ 䗥ˀ G2\ \\  %P\ 0 >Z\\\ \ h7\'  #QG} 2\  )ag)n\ \ 3\ . GE-\ 9 h\ S9 ;K<\ I3D$	\ (   *^ >I~f. \ a\'odNbQ\0؈S e  U bdHS = *\ ˯(m\ \ ;s \  % Ozy |  O6y W \  O
)\ S k ;t  ,`, ̈ݎ\ \   \ o    AJˍ ڷ   .\ S $ve[\ r\ &6 \ \ Ae\ ;* b\ b3\ ļA ~\"߲\ZB \ B4 ) xt[ \      \ } 69 \ }  \ )   6 m  eĐN Oy`f_ ǈ׉ \ r} \  yR  j`  :&   fSk\  \ 7  \r\ 0 6 \  O [ \ [\ vch )\ fj H \ ~H b\ 1ځZs K \  .  ; N\ d\ Ь&\ W  rK  \"\  <  麣 .c 3`  EL\r\ \" L O\ (\"ExJ  _2_2T\ \ t s   \ VP \ ޟh\n\  -7  nX sED= 叴 \ 6*\ \ ] b 3   \ اi|   D \ \ \ (\ y  dZ\ B   *KV\ Ġ	 hB #\ B c\ A\Z\ +˟  \ +K 
L A\ \ a{  s{\ ;  \"׵E}    /\r% `xdڬ)\ w d \ <Y-.\ \'\ ҵ\ B a  n {\ D \ \ ;\ Gqcz y  ^\ ˜\ \ \ u\ \ .\ \ -
 \ yٗx   \ c\ \ .\ \ & @ \ ٤\ 6a\ \   n      1 P s\r{. +l \ X\0 \'  l@ 뉱 s~۸   JʳM   	$\ \ ] ` (!ڡ\'뛘  6jA\ ݇  \ \Z    \0zR9 \ TBrAD<t\ \ &  \ $ \ J D 	usu e      JYoS y6I  \ 	( 4\ \ I ?~ d ..3ap,  \ \ c \ M \ \0- 1/{
\ Q|&N< T,\  m\ ˴   k1 @\ A\ ^u \ ]o%\ *  _j+0O \Z1ʶ \ \ +ZR  ۠ 2 5      T.or*춑\ 3 k\ ;gBN l\ \  6b\\q\ 9:mg 1  \ Y  \" $`\ \\l\ \"  zT e 4    $   }  3\ \ !
i\ \ U \ O3*  { : f a Ƅ\ Kb @ > \n \ kox     w2q \ \ K \  \ bo\  \  ݭ\  \ 4} b  cA +\ 2Q^\ \Z   \  \ \ vI =\  y%   \'{\ \ K\ \      f\ k#	A @S %;=?\ \Z%\ C   ?  D 7 [#3\ f \ a\ ; k=7˰A  (   atmI~G<&[ N\ e Wy+ @g\ bFQ  \ o\ ; D\ (  <Ŀ  *  \ x  TMLTj    o   j 3$ \ =\ 1 m \ \ { @ 2;3ͪ,Qp\ 3<DRChܵ͹  \ hENh 鯕 \ Wn\ \ \ \ U^ \ Í(
*G<:  \ tJ   \ 7b   P\ \ R   \ c\ 4 \ p\ -E\'! D pqh$F ؤ_J\ \ Xօ)      \ \ i & \ ň\ m {\ l lmV j C( R \ 0xy \ < 8]\ h /;\  S b U 7\ <2b\ \ 3g \ Y \ | ̏  {  MũKZ 1p - V\ ,\ \rL]\      \ \ !b
\ @\ \ ! -ȑ< \ R X j#kN\" G#|\ y \  0Qv\\ \ Kp   \ , \ B #\ a9\ \ +  e \ \ \0 J   Jc \ ֈo\ 9 } o7 \  \  c\ v \   1 	 \ f pT\ s X\ny\ 2X\ S2 !r J &y \ i %J\ <\  \ ~ \ g_  \ (\ E;@t \ &\"   DT \  M\ \ k m\ \r\ \ \ k{y\ -\ ~b   1. ]  &]7 i      \  \ \ e \  v!|h_  y (\ \ 6 F\ \ R\ B\ J \ д \0  ׹1  g\ VZf\\\ \ `@\" Qfb> ƶ\ j \ZcJ 3]h\ZTK \ eoҤ\ \ ؁  䙃7\0t  Z 37س.
F %a^ G  <G\    S<\  Zl   \\^  |E  d1V)7\ ܳ  \" \ Ƣ   I J ; \ YH\   \ hM  諙j k\ p`j$   1.\\\" *8 AHa A WC.\ \  \ Y..  G1t^ \ r\ \ K\n   \  2\ )\ DVՖk(\ %\Z; T TGI \ oDA\ t  \ x/< h=\ D3U;!X  D\n>80- τ\ d   w W$yj;\ X\ `  P  \  Lzъ \ 2[	\ ͍h Ľ ; Δ\ *yʋ ?P  \ s=Ί   WΥ|\ z\'̲Y, \ K\ \ 1, K \  씖K<\ \ \ /\ { <s =\ ;\ S{   M #Qiv\ `m  A j -   
&S  \ 0B  ޱ/2фc MŔ- sν \ Ϊ \ \ \ \ \      x %\ Kd \ \ )\ 4\ 0@; q#      Jx  }N\  \ M \ R   Jҙ  \   \0\ \ g  \ n\  L\'r \r\ \"\ZS ulb\ \ \ 
,*)xU  ֈ\ \ , ]\ &\  I Jt sRzЍJ & J \ K94|.B  ҘW HC\ \  \ ſ  \n\ ^\ nx\ \ A\Z@ 4d  \ \ V\ \ َ9 F[\ \ n Pd  0\"
\        !	1P \ B\"     \    \ V \n\    } k m  6\ 4 E   lQ C/J\r$  	 <\ `\ . 8 }\ ^ T \nm{0\ 
U  Ef\ \ E &\\5$ og \ j݀-  \ n  2fYN\ m 8 \ Q \ t p h \ Y\ \\KxR L)\ \ 6\ \'GvV\ \ ̹> )  
<\ 3S   2\ [  {o ڥ\ >Ǣ\ jW\   \n\ ѳ\  6W   )Q0    \ \ \ \ \ W   \ t[ a i   79[C  i +E\   \nw\ [\ #ݸ \" N   . 7\ \ \ \ 7B\ \ 3 Q\  з\ zdKw  \ K \ \ - *g Z    \ )\\N\ 4f vd  \0   u\ .#i\ 0g [ed\   \ mR$\ 	r  \ e QaM$   Uԯ\  y U 73 w T6\r\ H6   P  Ň T? !9D¿\   \ % {˩\ MW\ ^\ b>  )F   ~W
\ GgǄ\ H70\\ c	>\ 8 zj  6Pڃگ\ X U b az\ !Aǹ      { t\ Bs6*X{< V  a\ Xrhj<G`\ (    0  u u 7 ]+84 
\ \ . ?<:Z w|\ 9 T2$,4;  6  m \ \ \ Jt*=؟  X ٌ\ Ō q\ s m  6 \ ZK\\\ $̼L}t\Z\ \  \ y| \   \ r\ l̶[/L H  L˅S2\ )-   x\ a ( A > ܷĶ[>b\ \ \ \ a\ [\ il  \     R\ \  \  \0+%P  <\ \ O\'L <\ \ \ *y3̞d <\ X\ \ \ ڠ  <\ 3̞d < \ O2y3ɞd \' <Ș\ \"      < \ O*ySʞT <\ \ O*y3̞T C\ 1 M,* KЄa\ ?oM A T   }/n\ 1\ z,\ \ \ \ \ vH}  g A/\ \ \ZC=  ْ } \ e; GR  u,y\ \n\ D \ 6\  :\ 5P\ _ ;  Q8 |\"q\0(  \ 1Z W@;   &j Z\ - \ L+zN  :\    \ i Ub l X {;\ h⚥\ Q u  i @  \  f{_ C \ \ y   b%  c   9Z\ f.\ ثd垨y\ \ 6 ! m\ \ F  _:   6 \ A   \ Ol C9 \r\ ~2\ 1܏ Xjpj  ֗F#\\̽dY  \\2I Ww]O\ :
 y 2  P-\ ;#(\" cg     pm\ ʬ e\'  r Dg Ga\\\0 b\ \ \ cN \0\  L 8O \ 9Vj \ tq\ ;C X\ +\"  B   7\  \ \ Ww|\ ?    _b	@\ p\  A ݆\  \\ `F n \ cZ \ \ e簐˼ \ z\ \" ОP屧  vxnYK5\" & J1\ 8x  )  j !\ 5\ ɧ!\n\ \   pݜxq \ XK  ~  \ ԰䊃w\  7 \   \ & ҹ  M  l خ  J\ (    R/ uV :1    = x\ % M6   \ p \ *$UA \Z pZ\ 8g cnģZ4K\   \ ~ 3  5 :A   \ _s    +  \     (Km s\'x#ay+ \ \ \ \ | umY   q\   Xy  \0  ߃[ z 4  * Km\ T\   r 0k  \ \ =   D \ \r   +i] M  X\ \  tZ m\ ][\ \ \ gv+ 3 \08\ / MN  +c * L\ \ ; N\ E  -u s \ \ ʍ\   [ r̐  \ `ҷ| QmF \ 8 Wc  \ U Tc K    	\   B /h\ #n HQ \ g\ o=  P HN\ \ |  \  \ \ \ O  =>z|  \  \ g\ O  =>z%\ 
-\ ԗc?\ A#\  Ϟ =>z|  \  \ \ \ O  =>{L \  \ \ ] \ >  ) \0\ \ /\ |  \  \ \ \ O  =>z|  \  \ \ \ O  =+\ \ \ \  \0 _ \ \0\0\0\0\0\0\ ~ \ ?   \  < K    s  \ \ , \ O|0\ p $\ \ 0Ҁ	_l4AA\0} \ @\ ^ \ AAAA\ } I6 AA F\ Sqm M$A } _}\ \ } A@\0 \0\0 U \\q\ \ M5\ ] A} \ I4A4  \0Pq\ \ A} \ y \0	\ _} \ Mg\ C ^\0\0A \ ad		 _S0 \  \ AFq\ \ k  (\0S	A\ 0 \0A5|8 \ 	1 \ m{ \0=D A5 \0 \0CO 8 \0\0    ad@8\0\07\ Q\0A\0\0\0-        w\  \0 \0\0S\ A A$\0\0\0 \0$ 	(  \  Q \0\0\ \0\ M6q\ \ 0 \0\0      PA\0 S\ }\ A5\ y\ \ E&\ ;\ 8  <y  WiP \ yđMU q \ U   {\ - 	/ l\ A4C\0 \ ) E\'\\q\ \\ \ \  \0 \0  $ \  AFAP\ \   C\ \0\ 6\ )\ 0\ \ +\ S \0E!\ A\0V0\ \'i\0\\ \ \r\ 0\ A0 7u \ e \0 \0@!   t\0A\ 0\ 0\ \0  \ E \ A]0\ \ X0 AO \ 8\ \0$ 	pI \ \ \ 4\0\0g\ \ M$ \ < \ <$F~      ` \0b \0 _} \ | \ BK?< Sά0\ \    \0\0 \0  \ } \ 0\ \ \06     \0 \ \    \0\0 @ OP\ p\0\0b   O  0A \0\ \0\0\0 \0  _x\0\0\0\0\ \ _  B,5 \0     \0  \0 }= A  0O= \ \ \ \ \ <\ \ _        $ [ q DCP1 \ \   \ \  \  	w\ 9d\0\ yߕ\r \ \0\0\0\r<\ \  \0   E\ \0@ \ z\ !\ |\0\00\  \0 0 s\ \0 M\ M\ S  \ !hAAU=\ ` \0V9\ a\ \  h 0\ \  ,\ < \ iE\   O\"
 G T\ \r? \0, \ c4 k \ 80 \   \  \ sA\ q  8f\ \ r  \ S\ h  0\ 4 C/ X \rO D0 ^  \\ < \  N0U\ \ G3	0\ X@0\  \ \ b) 0@*s \  # 	<# Q\ 
   G\04O} (\   A| \0.k\  P5,x  T0LkC\  \0Z \0\\rc  RD!, \ \ \  z0\ 8J 5 \0C\ \0\ <  Y \ 4⌢|< \ ` E( | A\ 8\0  7  \  +   <\ \  \0   \0 \ Qg\ I\ T׏%\ 0\  -(s  \ T0\   \ \ \06 < \ rC  0 !\ +\ \ \ \ \ ѫ # \  s\rxC
	\ \ \r~ g\ \ ~\ \ >  0 AXNa\r4 \ \     L4 \  ~ڪጡh n  Y N ӿ\  ( < <&d#  \ , \ 3uE  f\r \0\r\ ^    } 6   䒨s >5ݱ?<\ \ 95     !    \0)\ 9\ -,  \";\ ,3\n\ :   \0 Z\        }\ \ \'\ \   # .\ z     \ g\ 3O b *   0qj 4 \ ï \ ` \ c K# _   GB4 X) *` 
 +/ \ \ ?  
( k  A\ \0B 	  \ ! N8 ɩ K1 <\0 0\" 6@\0<Q0\  $; !, \ \ $0 0+J\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\01\'E  \ 0\0`  $ 00\0\0\0\0\0\0\0\0x+< <B0sAP r\0s\n8@\0\0\0\0\0\0\0\0  l@\0\0\0\0\0\0\0\0\0 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Q\ , \ < \ \0Ks\ < \ ,\0 \ < \ < \0\ \ L8\ M<0< \ 0\ 8 \ \0 \ 0C<\ \ O<0A<  < L<\  0sO(S\ ,\ \0sO<\ \0<1\ <3\ < \ \0\ \  \ < \ << \ < \ < \0\0A0\ 0\ \0\00\ 0\ 0 \0\0C0\ 0 \0\0 \ \0#\0\0\0\0\0\0\0\0\0\0\0\0Pa !10`@pAQ  \ \0?\ E 
2T8  M jD \ S	(OF` pv °\0\0 \"\  \0$` \0M \ $$E o\0  \0A \0   3\0U\ \ m\'2\ \  \   ]1`  \0 G\0:    ` \ U\  \0R9 \ \ &   p*ɽ \00$l&V` 29	2 \ ¦\  \ \ U \ \ \ rT7 \0 \ / 9r\r( \0@\'0\ ?     i )B\  T\0  A\ A \ ia J \ n\'X ^   \ v|\ 7  \n (R93!  O  6 \ \0!\0\0\0\0\0\0\0\0\0\0\01P!` @AQp  \ \0?   \0 \0\0\0 * 
 ~|	  !0!L/ ?\ ]G  F  \02 \  >  
 #/ұ S.x  \  @2w 
ȟ~)  _  \0 nU \  	
  
m \\Ob Q 8,ѢW \rB\0  N\ F\0\rA\ \ QC  \Zm  \ Wĕ\ `? \ 8x Q ߉?´ 0~\  \ \0+\0\0\0\0\0\0\0!1 AQ0@aqP  `    \  \  \ \0\0?\ \ A H \"I$I$ I$ i$ H\ 6) $ C$ E I$ G \ EiÎI# rI$ \ 1\ q\ )&l\ ΰ @\00  @ \Z\ d\0aD- 矄\0\0#\ As  \0\ O\ +\Z\ w`\0M  >\0j\  \ \    @ \ \ \0 \ A;\ I:` 4Gn
 e\ v\ # \ \0Op V   3Z֞\ `_uGYt e\ ]\' \\$  \ U :\ \ b\ C\ \ S  d\ ~݄A :  \ \ v0EQ\ \0  F \ u* ˗  \0A  
 \ ~ \ \' \0\0  \r׉ 4\0\0& @\  y    \ _ `\0\ \ 
 0w ,| \0,L \ 
B7 \n\ p\ ? \0\0\0\0  H\ D  \ N\ \ # \0 [X7  _8\0\' @-& >D ހ \ \ \   <\0\Z4@   ;P\' \0\0F  !\ \n\nr   \0 Bzp  è ( Mg~   غ\ \ \ oQ\ \02 ~\ 6°Rd  \ZHuQ\ \ Ic\\ @ @FQr!\\Æ\ ?  @ T#.: \'\ \ \0I=\0u@ \ Y7 ׈    T  \0 dR;\  0H  z  Ol\0>\0
AD`\ l 	: >\ *\ \'@.\   ;P\" `BM0 T  \0Oz\0@  \ \ *FSN  (\  \0  !  ;\ #  b9#.]\ A\Ẕ  5P\ KX  P \\h  q   xi(    
 \ 7  7\ \ $T#kH\"  \" Z H#Hާ\  \Z  \ >L\ ` \0 
ڄ +tO %N>0    \ \0ۀ/ \0M\" \ #- \ ~ \0\0Xb/@$1 % :   \0O\ \nS    .   o \0N\ \" 	\'  \n\ D\0F;6 HM \    *×Q u\ 4 1@?D\0@\  1\ lO\ @\0\'P1\ E0Eh\ i  AdM v N \\ O\0 \  \ 0\"\0  : C\ \  S B\'\ \0\0\ %:P \Zh\ /    { ` #\ $  \ \ <$a \'̀	@@W:BD \\   Qn\   6V.| \0
VD X\0Ԅ%H # \ 93 `\"  u4\"\  ` ߀X 0>\ \0xΈ\0 \ ^p_  @   ]r \ 1\'ݺ  \   yt \0   C@m  &L&2h\  H\ \0 A  \0dБ.   \ \ ׹_ D ߀\0 \ z \0-C
 \0<2
# ; \"u$\ BjOx @ H8q\n ! \ *B{ XFvy( $ 
\ \ ) ~ \0	\' 	\'@$     \    \r  s &\ \ 0 8 A [w \ g   ( + \ # H d5\0 \ H  (\ 
[   \0  @8 Y  \ P$Hn;p!   4 \ \r  A\0 j@ 6% W	  `  苿\ T\ 7 \rA$\  2r@h$|\0\0	 m P\r ae\   -\ e:  a\ a $i I\'J\ >\ A- I bl| `   ֧ tC \  Vk\'B; > \ 6 \'P$ `>Ĕϱ \   \ N \ K ؔ   ȁpcdPA	 <\0z 2 (\ \  5 . Ō 	\ \0h  t  q \ LF  \   \ \\ \  \ T\'\   \ kH\  !  \Z\ \Z= (W$  *$\ \ h\ 9\\,\ ` {\ 3\ \0 I\ c\ BF >B5 
mbXSbh \ <\\ )Fx@P? !EL	*	\"\ \ T$ P . 	& \  p: ӄ\0	0͑\ 6\ @.Q !\ *XP \ o! F/  6 !
c Ґ\'\ A$ \ =2BD`\ \rD\ (\ \0 \ 	PE\ BO,i9D \Z \Zl!ޡ	\  m,    9 \ P1mD \ @  \ \ &  4AN\0 ɺ Ųhd 9vW d  \ \0 \ $ c  Q=s l  h	`0F:` L  #j\ Ei\ 	   H(  \ yy F 6\ \0>\ ?\ P\ \  \0S\ *\ xIa#  \"   &{   K\ d ig\  s ߀4 \ ~\  ` 	 yU[  lG%  e   d5\ \   QJ d o 4@^  Ov\0J \   ag	\ y bu ( BY E yl C\  4k f	\ =P#   KQD\ b  r 	\ \   eY\n#B ]   \0\ u	 @\ P J Az W(\ qjx\ Ѐ \ h\\ 2β*S!l6 \ \r\ \0\ P\ Y V A,  J \    \ D \0\ Wa$ \0@ E   \ \ ,M-)SI\0 D2     \ \ Fp`S  J$ *% } D9\ gў C      l#` 
 \06  	r_D f = \ #k)p\'  \  H0 .  M  ^@>  6\ a&\r\ -w w  j\ c A \ K\'\"    8 ˘ mX:\" = \" \ C bC4n	  l4    h\0&E Ȼ   \  1 \ L\0  :-\0a\0\ $nɼN\   ;Q
l 
Y \  K> #\0 X j #(lӸ!ŤDܥ ._@MK 
W  \\^\0\ r3%\ p XX    \0QW IɒA  \0  6 1(0\0    @ ݨ5xz#%\ R `&$ |U$ 8	 %  @cs
\ A`\ rCK xc\" \0:\0\'dM\ % 1v$l  \ XE ` \ E \0 ä
F\ 3\ :H   C \ ,,F     N * \0\   P \ \"\ ] X0 \  \ \  \0b\ x֠@`  A\ \ )TX UH fB ( \ =\ \ B^  BBE \n5DJB\ v   \ +   \0 TL eph %B5\ W)  )>\   \0I$ \ # د\ t	J\"T\ \ d@D\r\      2 a2\ +     R%D1     \' M	 { p\ Z Zm JE``\ x0?    0  ~z 	̩*B\   I \ x?   \' 
۞Bd r+y !@\ = \0}	섍@\r\ \ LX pIo,  \n H  *\ O  Ϡ  
\ d 6ԭn\ H q   \ \   A \ZLm a0  $ $V
C\ \0G  I\ >\ p\ A E =  Ȫ   
  	A \ #  \0\n	 )dC  \r0 \ ,\ |\ 	* \n  J\r ]   $\ !*N\ \ IX   Tؔ6@D @Y  DȄSL\ \ @  `\ M  `  e +@ `/  ꠀ a)H$E\ J p  &ȃ*k< @,\ G \  ( a  \ tv\ C) < qD\ ԨJ - \r Q2  
b  ,25e  \"  @u  0̈ E   \ 2 \ =\ ;\0t%\ \ 
h@\ Pv C ! i
G M\ TV\0.2$\ (\ b yu 0*Ôp˃Ny0Ԉ7 4 ͟R-)\ J Xc P  3 V\ \ \  }R -Jn\ ch X*\ 
  + ɋ\ V*\  W\0X\ .  \ 	o0 ٖ QH \\\n$Aě2< 0\ \ \ _    6I  9*\ Y|\   (
 $L(\ \ [ GgZ59P  $D٫  FGCۓ  m \ZQO \ M5 ! l @   @\ c:PtE *M-V   9 0*  z\\̦ b    b@V RZ|\ ƒ3f&k  \ F   0 E \ ]\r  n \ 9t b\ ``˩jn`#  @ w` H H x5 H\ }\ y) z\ X  pD< è LX4 l)\ Q Լ( \ \ c Mr\ AմJ \ l򃺮 M2 J a
   \  H7=W
2R2 <m  \ \ \ \ %*\ }\0 \Z\  H\ l \ !M  D PFi 	  40~\ Z~\0@ \04   /  ?a2  AbK)%Ĝ
*l  $1nP\  + @  * 3}    !\ \n\rE 1  h\ \   \r\ q1\ F \ ) \ \ \  $I\ k( \n{X\ b͆@> S xI $\  $# \ Z\ 
 Y D\ !6j \rĴ 5 [ \  ,  B )\ } E \ I <\0E@D \\  # 
\ [\ {_   T \0  Tu\  $u  \nDS4r- dnb  \0d; 4Q\ |H   $c\ZC 0\Z !  J76\ L\ \ \0 { 	)&\ \ c \0Be    = \ \ \ \0H  P\ 	%h
 	 \ ܺ\01u  L  p	\ } &]  +LvM`Y\ 8%- \0 bsj8 Mo&܍ \ \ ^ 
 j \\ \ QB\r \ \ \ ) k;   \ \'ԠIv\ 	 m .(¬$  j!QA \0 \'}I  S  dh \rp [    \r   $ \ \ X\  \0  n  ۖ\'\ LC D   .\0    v @b\  %5  \ r   (&h*t  ʒ z\ ; 4@ t \0YAZ)A   9\ \ }\ =\ )@Mj6pZd\"\"3 H\ #\ @ ˗ \ m l8k S  ȡ\ I H}Bf Ʉ( \nZ3M z ʑ\Zy\ q\r2\"\ t \ DGȠ3\ n*   Α P\ \"\ %=mF\Z2C\ % \'ɌQIZ )m2&(n@ \n\   ˚@C#\ 
 \r\ 	cD\"  \ p		  rUHUj \Zt4  L % u@      B \ 
\ \ $3   g \"~٢ =)~  \ S \ )?\ M\ XV?  c\ ʊ 
tz\r7\ cB7    쨐\ \ $    D	\ \ \ \ nb \ \ Ve 1 BH$BT 	\ \0sa   \r {\nl/t840j F~  5`;  & P.ޱk Ҁ\0@ $\ \ \ \" p \n\ h  6   ݆   z\ ZȆ\n0 nP\   PǢ
M \\|k\  \ r\ xd  BG	\ \ - \ \ \ \ b\0 Y  HN\' \    E9  F \ 2-G5\0N \\  0@\  15xP    c\0Ҡ# \0\ J\rƙm -J    y\ t~&\'\ H\ 6ϡK >\ E   Z\ o\ %B  ) \nR` 0  \n   8s\ b 1gv\ \ \ \ K A0G5 \n %5 4 \ T \ /;<2P \ `\ \ \03 -ͣ \ \r    !\ \    \ \  \ LM{  \ !ҩ0E\ \ )  {    s  0 O #E\ aj9  n4\'R A߸   \0&  Wտ\ aUv[ \   D! \ \ ]@ qq-@ Q   :?\ \ ?>\ : \ \0   h, N %\ Pv8u\ _ $<n%; \   p AZ    ˞\"S3	5΀k \'    + h \ / kP \ 2 q \ -\ \ L\ iËmCv. \ l \ i{4 _ j C \ \ C  \ \ < \ ,Tu !U   Q  \  z ` Y  \ )    g x \0,-\ /    ƤTTx   

  @,  ! 1\ \ dҤZ r ňAFζ{\rF\ \n\'J-F \ k> \'%\ 
\ t- 
  rn@<b\ Ať(
\ 4 \ ɀ \ R kf l  \ h[! \0+ʥB \ \\\ )     P!\ 	-ȯ\"\  $   AN4\ \    F@Z \'\r   ~\\\ \ 8   1  )9(  a Df  - D \Z P*  b  L \r\0n& 	\n \ZK B\n  D u\0 \ \ \ l:`@iL` \ Q@ 4P ـ   !\04\  \ YT !@\0b   kP\0\'@#   \"8ak5  !     >H^up  DN  X(   ,\ 1t(\ \  \0\0\  @\08  zD* ȹAc .\ \ &E ) \0 	\  
   V \ I 7\0 kh3\ M)> \ B\ \ \ \     \ o\ \ % R  Af \r@( 5A$\ @  u peC\ 2`#\  \ l4(r    %\ o  r  \ P\n 1tՀ\  T  iEBtȢ \ RV     )\n\ \" 
# { \ \ h \    c0  Am a\ D7\ \Z[   qP9aD \ m l\ Y F    @\ \0   \Zb O\ M\ t\ \Z BBC}Y  RO)= -xD 1rO4 tyۢ<\ \ 񧴊Bt % \n\"]j ) # J%@0oIL  \ P \ A U1\ B.s 	$|\  \0  \ \ P   :^. & \\ \ <!\ gJǠ\ZNhU  &8i D  P L   \npR:\0\ \ J# ɵpTI Lm\ \ h& i    ,, 0m\ \ m \  |\ \ AзohL v  DX\  #\ \Z~ K    <  \  F\ Q  Eh   @ͦC\ j Y J @ n      ]!H J ț4wwӲ< 
4  , (T*  R\ \ P;\ \n, !\ ?\0+  W j\ \rZ  \ \ZUt L   \ \n \  \   \ a!e\ ]@`⏐  Hñ \ L $ \ \rJ( \0n>   \ /\ ` \ Bm   CH2Qp O \ f$ v1	 	9bA 3w> Я Ju\ M+Iv j\ ln , h 6|( 8w0   \0\ &L   t9     g hB \ \ TmA\ \ ُ      g\ ZZ Z 	  f\\BKRoG+?m%Ͷ %I  \  \ E, \"e xUL\n  ܰ Q\r\ acxt ȸ  J)\ \ G\ \ qi \ Ew{ CC \ z T \ \   \ \ t \r\"f1?   \  \ \0  3 \ d <     h\ : F    \" 6(*s1a 73 \ Pdh! 
 \ ϖ ˘7(q   x  ްMLI |A\ 
LV \    \ R# \ gT\'C F\ p\ \ > s \0  ꦜ\ \ kwv\ Q D\n Pb(b\ ]R . A  K\  (    VI)bG\ # HV 9}\ \'   B  \ &\ \ N7 Y  OB H M \  \ \ +\   \ \ Rt ST  %5Z@ ܓ)\' bޢ  H^ܨ7 \ jN  ]	 B
 rv) 3 1 3  \ \Zr 3  c r~ \ L  Ȍ\ \ ͋ڀv[  ݌    ɘɛ\ b C\ @\ \'\ ސ
\n\ J[    \ \ \ ۦ  !\ _W|  o\Z \  t	J\ \ * W\ v \ y\   Ž\ hNk   *\ :\ u Uq\ z   h\n \ $\  Gh\ Gw  ` g3\ \ \ &j&#  W   %Ɵ    ɸc-    hL  챲\ +\n ag\ ,\  \ 2\ # \ eP W^ȃ aP  $ N \0\'> F(f 	=	w 즓  s- :\ L \  \ d Q %\ Դ\nj|   \ tP&  s  \Z\ HH\\\"      j\ f \ ذIA\nP\ ,; \ OD \ \ \ Ne | Qh \ %\  \ 4P_G \ \ \r\ %Qb  M  \\\   @ 7pzy ~ D 0$  p 
!#\ p    J ]k\\ ў O$y(W6     o \"	   Ь Ȼ 4Vgahp\ Qt  \ 8\ [e   ?   C# $Bd7S@N5 1 B  \ Q\' t  	  г *Z t8 V ~l4b  j  \ D<6
\ZeT PD \ \\
K@!  oK \ 5\rP Ƀ p J  L >Nb   \  \\  G \0\ \ Y`1 jg\n Q a \n   =Ш@ \ \ \ $ݩ$   F)\ Ts ,\ ?d 3\07& Q}& \    \   \ \ ! J  Sɞ\ p\rO(z\ 긋\ 2{E \ &\ n \ = [;4   (g J  6\ g\     )JR   ƩJR  60 U    \r   m)JR  )K  2  \ 4 -N` 7    JR  )JR  &?8 q W \ '),(8,'SALE','sale','Discounted products','/uploads/categories/8/1752164160679_untitled_session0156_c644f3db69f74052bef5b087ebe22e2e.jpg',NULL,8,1,'2025-07-10 19:43:36',NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_usage`
--

DROP TABLE IF EXISTS `coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_usage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL,
  `used_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `coupon_usage_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  CONSTRAINT `coupon_usage_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `coupon_usage_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_usage`
--

LOCK TABLES `coupon_usage` WRITE;
/*!40000 ALTER TABLE `coupon_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupon_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','FIXED_AMOUNT') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT 0.00,
  `max_discount_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT 0,
  `valid_from` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `valid_until` timestamp NOT NULL DEFAULT '2038-01-18 20:14:07',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'WELCOME10','Welcome Discount','10% off for new customers','PERCENTAGE',10.00,500000.00,NULL,NULL,0,'2025-06-29 07:57:42','2025-07-29 07:57:42',1,'2025-06-29 07:57:42'),(2,'SAVE50K','Save 50K','Save 50,000 VND on orders over 500K','FIXED_AMOUNT',50000.00,500000.00,NULL,NULL,0,'2025-06-29 07:57:42','2025-08-28 07:57:42',1,'2025-06-29 07:57:42'),(3,'SUMMER20','Summer Sale','20% off summer collection','PERCENTAGE',20.00,1000000.00,NULL,NULL,0,'2025-06-29 07:57:42','2025-09-27 07:57:42',1,'2025-06-29 07:57:42');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_code` varchar(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT 'Vietnam',
  `tax_id` varchar(50) DEFAULT NULL,
  `customer_type` enum('INDIVIDUAL','BUSINESS','WHOLESALE') DEFAULT 'INDIVIDUAL',
  `credit_limit` decimal(12,2) DEFAULT 0.00,
  `payment_terms` int(11) DEFAULT 30,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_code` (`customer_code`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'CUST001',NULL,'Tech Solutions Inc','John Smith','john@techsolutions.com','0123456789','123 Tech Street','Ho Chi Minh City','District 1',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(2,'CUST002',NULL,'Fashion Retail Co','Jane Doe','jane@fashionretail.com','0987654321','456 Fashion Ave','Ha Noi','Dong Da',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(3,'CUST003',NULL,'Book Store Plus','Bob Wilson','bob@bookstore.com','0111222333','789 Book Lane','Da Nang','Hai Chau',NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-06-29 07:57:42','2025-06-29 07:57:42'),(4,'CUST-2',2,NULL,'Admin User','admin@gmail.com','VN-0389911823',NULL,NULL,NULL,NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-07-01 18:22:30','2025-07-09 14:42:07'),(5,'CUST-3',NULL,NULL,NULL,'quocbao01651@gmail.com',NULL,NULL,NULL,NULL,NULL,'VN',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-07-05 08:48:11','2025-07-05 08:48:11'),(18,'CUST-5',NULL,NULL,'nhi nguyen','nhi@gmail.com','VN-0389911823',NULL,NULL,NULL,NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-07-13 05:12:12','2025-07-16 08:23:21'),(24,'CUST-6',NULL,NULL,'lam lam','lam@gmail.com','VN-0389911823',NULL,NULL,NULL,NULL,'Vietnam',NULL,'INDIVIDUAL',0.00,30,1,NULL,'2025-07-18 09:47:26','2025-07-18 10:22:24');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_logs`
--

DROP TABLE IF EXISTS `inventory_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `action` enum('STOCK_IN','STOCK_OUT','ADJUSTMENT','TRANSFER','RETURN') NOT NULL,
  `quantity` int(11) NOT NULL,
  `previous_stock` int(11) NOT NULL,
  `new_stock` int(11) NOT NULL,
  `reference_type` enum('ORDER','PURCHASE','ADJUSTMENT','TRANSFER') DEFAULT NULL,
  `reference_id` bigint(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `inventory_logs_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `inventory_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_logs`
--

LOCK TABLES `inventory_logs` WRITE;
/*!40000 ALTER TABLE `inventory_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `type` enum('INFO','SUCCESS','WARNING','ERROR','SYSTEM') DEFAULT 'INFO',
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `action_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `product_name` varchar(200) NOT NULL,
  `product_sku` varchar(50) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT 0.00,
  `tax_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `size` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,'HADES SPLICE POLO - BROWN',NULL,7,521000.00,3647000.00,0.00,0.00,'2025-07-04 17:41:19','2025-07-04 18:52:57',NULL),(2,1,4,'HADES ROCK SOLID ZIP HOODIE',NULL,1,850000.00,850000.00,0.00,0.00,'2025-07-04 17:42:23','2025-07-04 18:52:57',NULL),(4,1,2,'HADES CHAMPION TANK TOP - BLACK',NULL,4,420000.00,1680000.00,0.00,0.00,'2025-07-04 18:58:56','2025-07-04 18:58:56',NULL),(9,2,3,'HADES COZY STRIPE POLO SWEATER - RED',NULL,1,1150000.00,1150000.00,0.00,0.00,'2025-07-06 13:51:30','2025-07-06 13:51:30',NULL),(11,5,3,'HADES COZY STRIPE POLO SWEATER - RED',NULL,1,1150000.00,1150000.00,0.00,0.00,'2025-07-06 15:55:37','2025-07-06 15:55:37',NULL),(15,6,6,'HADES BLACK WAX BIKER JACKET',NULL,2,1190000.00,2380000.00,0.00,0.00,'2025-07-06 16:13:52','2025-07-06 16:13:52',NULL),(17,7,8,'HADES VOID DRIFTER PANTS',NULL,2,790000.00,1580000.00,0.00,0.00,'2025-07-09 14:16:44','2025-07-09 21:16:44',NULL),(18,8,8,'HADES VOID DRIFTER PANTS',NULL,2,790000.00,1580000.00,0.00,0.00,'2025-07-09 14:16:56','2025-07-09 21:16:56',NULL),(20,9,6,'HADES BLACK WAX BIKER JACKET',NULL,5,1190000.00,5950000.00,0.00,0.00,'2025-07-09 14:42:07','2025-07-09 21:42:07',NULL),(23,10,4,'HADES ROCK SOLID ZIP HOODIE',NULL,1,850000.00,850000.00,0.00,0.00,'2025-07-09 14:49:35','2025-07-09 21:49:35',NULL),(24,11,4,'HADES ROCK SOLID ZIP HOODIE',NULL,1,850000.00,850000.00,0.00,0.00,'2025-07-09 14:49:50','2025-07-09 21:49:50',NULL),(29,13,6,'HADES BLACK WAX BIKER JACKET',NULL,1,1190000.00,1190000.00,0.00,0.00,'2025-07-09 14:58:07','2025-07-09 21:58:07',NULL),(32,14,6,'HADES BLACK WAX BIKER JACKET',NULL,3,1190000.00,3570000.00,0.00,0.00,'2025-07-10 11:40:59','2025-07-10 18:40:59',NULL),(33,14,8,'HADES VOID DRIFTER PANTS',NULL,2,790000.00,1580000.00,0.00,0.00,'2025-07-10 11:40:59','2025-07-10 18:40:59',NULL),(44,16,6,'HADES BLACK WAX BIKER JACKET',NULL,3,1190000.00,3570000.00,0.00,0.00,'2025-07-14 11:56:40','2025-07-14 11:56:40',NULL),(46,17,6,'HADES BLACK WAX BIKER JACKET',NULL,1,1190000.00,1190000.00,0.00,0.00,'2025-07-14 11:58:38','2025-07-14 11:58:38',NULL),(48,18,6,'HADES BLACK WAX BIKER JACKET',NULL,4,1190000.00,4760000.00,0.00,0.00,'2025-07-16 08:16:51','2025-07-16 08:16:51',NULL),(51,19,2,'HADES CHAMPION TANK TOP - BLACK',NULL,1,420000.00,420000.00,0.00,0.00,'2025-07-16 08:23:21','2025-07-16 08:23:21',NULL),(61,21,8,'HADES VOID DRIFTER PANTS',NULL,1,790000.00,790000.00,0.00,0.00,'2025-07-18 10:22:24','2025-07-18 10:22:24',NULL),(64,21,6,'HADES BLACK WAX BIKER JACKET',NULL,1,1190000.00,1190000.00,0.00,0.00,'2025-07-18 10:22:24','2025-07-18 10:22:24',NULL),(65,21,4,'HADES ROCK SOLID ZIP HOODIE',NULL,3,850000.00,2550000.00,0.00,0.00,'2025-07-18 10:22:24','2025-07-18 10:22:24',NULL);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('CART','PENDING','CONFIRMED','PROCESSING','SHIPPED','DELIVERED','CANCELLED','REFUNDED') DEFAULT NULL,
  `payment_status` enum('PENDING','PAID','FAILED','REFUNDED','PARTIALLY_REFUNDED') DEFAULT 'PENDING',
  `shipping_status` enum('PENDING','SHIPPED','DELIVERED','RETURNED') DEFAULT 'PENDING',
  `subtotal` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `shipping_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'VND',
  `shipping_address` text DEFAULT NULL,
  `billing_address` text DEFAULT NULL,
  `shipping_method` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `customer_id` (`customer_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'ORDER-1751655583103',4,2,'2025-07-04 11:59:43','PENDING','PENDING','PENDING',6178856.00,0.00,0.00,0.00,6178856.00,'VND','Sư đoàn 9, Hồ Chí Minh, Vietnamese 700000, Vietnam','Sư đoàn 9, Hồ Chí Minh, Vietnamese 700000, Vietnam','standard',NULL,'','2025-07-01 18:31:28','2025-07-01 18:31:28'),(2,'ORD-79192CA2',4,2,'2025-07-06 08:48:13','PENDING','PENDING','PENDING',1151392.00,0.00,0.00,0.00,1151392.00,'VND','rdrdf, Hồ Chí Minh, Vietnamese 700000','rdrdf, Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-05 03:03:05','2025-07-05 03:03:05'),(3,'CART-3',5,3,'2025-07-05 08:48:11','CART','PENDING','PENDING',0.00,0.00,0.00,0.00,0.00,'VND',NULL,NULL,NULL,NULL,NULL,'2025-07-05 08:48:11','2025-07-05 08:48:11'),(4,'CART-2',4,2,'2025-07-06 15:48:23','CART','PENDING','PENDING',7035330.00,0.00,0.00,0.00,7035330.00,'VND',NULL,NULL,NULL,NULL,NULL,'2025-07-06 15:48:23','2025-07-18 04:55:24'),(5,'ORD-00716DD1',4,2,'2025-07-06 08:55:37','CANCELLED','PENDING','PENDING',1151392.00,0.00,0.00,0.00,1151392.00,'VND','rdrdf, Hồ Chí Minh, Vietnamese 700000','rdrdf, Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-06 15:55:37','2025-07-14 12:03:12'),(6,'ORD-CE963B45',4,2,'2025-07-06 09:13:52','DELIVERED','PENDING','PENDING',9413665.00,0.00,0.00,0.00,9413665.00,'VND','21, 1212, 121 121','21, 1212, 121 121','free',NULL,'','2025-07-06 16:13:52','2025-07-07 11:09:02'),(7,'ORD-E29129D2',4,2,'2025-07-09 14:16:44','CONFIRMED','PENDING','PENDING',1580000.00,0.00,0.00,0.00,1580000.00,'VND','dsd, Hồ Chí Minh, Vietnamese 700000','dsd, Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-09 14:16:44','2025-07-14 11:58:13'),(8,'ORD-400D0675',4,2,'2025-07-09 14:16:56','CONFIRMED','PENDING','PENDING',1580000.00,0.00,0.00,0.00,1580000.00,'VND','dsd, Hồ Chí Minh, Vietnamese 700000','dsd, Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-09 14:16:56','2025-07-14 11:50:01'),(9,'ORD-57F3FC01',4,2,'2025-07-09 14:42:07','CONFIRMED','PENDING','PENDING',5950000.00,0.00,0.00,0.00,5950000.00,'VND','434, Hồ Chí Minh, Vietnamese 700000','434, Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-09 14:42:07','2025-07-14 11:49:35'),(10,'ORD-F71CCCD6',4,2,'2025-07-09 14:49:35','DELIVERED','PENDING','PENDING',850000.00,0.00,0.00,0.00,850000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:49:35','2025-07-14 11:39:14'),(11,'ORD-2DC93B29',4,2,'2025-07-09 14:49:50','CANCELLED','PENDING','PENDING',850000.00,0.00,0.00,0.00,850000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:49:50','2025-07-14 11:34:06'),(12,'ORD-DECD618D',4,2,'2025-07-09 14:54:23','CANCELLED','PENDING','PENDING',232.00,0.00,0.00,0.00,232.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:54:23','2025-07-12 11:24:22'),(13,'ORD-17D1961B',4,2,'2025-07-09 14:58:07','REFUNDED','PENDING','PENDING',1190000.00,0.00,0.00,0.00,1190000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-09 14:58:07','2025-07-12 12:27:23'),(14,'ORD-CD9A7FA0',4,2,'2025-07-10 11:40:59','REFUNDED','PENDING','PENDING',5150000.00,0.00,0.00,0.00,5150000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-10 11:40:59','2025-07-12 11:55:02'),(15,'CART-5',18,5,'2025-07-13 05:12:12','CART','PENDING','PENDING',0.00,0.00,0.00,0.00,0.00,'VND',NULL,NULL,NULL,NULL,NULL,'2025-07-13 05:12:12','2025-07-16 08:23:22'),(16,'ORD-97AEE336',4,2,'2025-07-14 11:56:39','PENDING','PENDING','PENDING',3570000.00,0.00,0.00,0.00,3570000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-14 11:56:39','2025-07-14 11:56:39'),(17,'ORD-F6AE736E',4,2,'2025-07-14 11:58:38','CANCELLED','PENDING','PENDING',1190000.00,0.00,0.00,0.00,1190000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-14 11:58:38','2025-07-14 12:33:38'),(18,'ORD-786A0C82',4,2,'2025-07-16 08:16:51','CONFIRMED','PENDING','PENDING',4760000.00,0.00,0.00,0.00,4760000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-16 08:16:51','2025-07-18 04:51:04'),(19,'ORD-72C966CC',18,5,'2025-07-16 08:23:21','CANCELLED','PENDING','PENDING',420000.00,0.00,0.00,0.00,420000.00,'VND','Hồ Chí Minh, Vietnamese 700000','Hồ Chí Minh, Vietnamese 700000','free',NULL,'','2025-07-16 08:23:21','2025-07-18 10:40:29'),(20,'CART-6',24,6,'2025-07-18 09:47:28','CART','PENDING','PENDING',0.00,0.00,0.00,0.00,0.00,'VND',NULL,NULL,NULL,NULL,NULL,'2025-07-18 09:47:28','2025-07-18 10:22:25'),(21,'ORD-01C3AACC',24,6,'2025-07-18 10:22:24','PENDING','PENDING','PENDING',9219110.00,0.00,0.00,0.00,9219110.00,'VND','1, Hồ Chí Minh, Vietnamese 700000','1, Hồ Chí Minh, Vietnamese 700000','express',NULL,'','2025-07-18 10:22:24','2025-07-18 10:22:24');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `payment_method` enum('CASH','BANK_TRANSFER','CREDIT_CARD','PAYPAL','MOMO','ZALOPAY','VNPAY') NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'VND',
  `status` enum('PENDING','COMPLETED','FAILED','CANCELLED','REFUNDED') DEFAULT 'PENDING',
  `gateway_response` text DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `resource` varchar(50) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'product:read','View products','product','read','2025-06-29 07:57:42'),(2,'product:write','Create/Update products','product','write','2025-06-29 07:57:42'),(3,'product:delete','Delete products','product','delete','2025-06-29 07:57:42'),(4,'order:read','View orders','order','read','2025-06-29 07:57:42'),(5,'order:write','Create/Update orders','order','write','2025-06-29 07:57:42'),(6,'order:delete','Delete orders','order','delete','2025-06-29 07:57:42'),(7,'order:process','Process orders','order','process','2025-06-29 07:57:42'),(8,'customer:read','View customers','customer','read','2025-06-29 07:57:42'),(9,'customer:write','Create/Update customers','customer','write','2025-06-29 07:57:42'),(10,'customer:delete','Delete customers','customer','delete','2025-06-29 07:57:42'),(11,'user:read','View users','user','read','2025-06-29 07:57:42'),(12,'user:write','Create/Update users','user','write','2025-06-29 07:57:42'),(13,'user:delete','Delete users','user','delete','2025-06-29 07:57:42'),(14,'category:read','View categories','category','read','2025-06-29 07:57:42'),(15,'category:write','Create/Update categories','category','write','2025-06-29 07:57:42'),(16,'category:delete','Delete categories','category','delete','2025-06-29 07:57:42'),(17,'report:read','View reports','report','read','2025-06-29 07:57:42'),(18,'report:write','Generate reports','report','write','2025-06-29 07:57:42'),(19,'system:admin','System administration','system','admin','2025-06-29 07:57:42');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `alt_text` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `content_type` varchar(100) DEFAULT NULL,
  `data` longblob DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (2,2,'/uploads/products/2/1751302620948_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,1,1,'2025-06-30 16:57:00',NULL,NULL),(3,2,'/uploads/products/2/1751306194367_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,2,0,'2025-06-30 17:56:34',NULL,NULL),(4,2,'/uploads/products/2/1751306203423_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,3,0,'2025-06-30 17:56:43',NULL,NULL),(5,3,'/uploads/products/3/1751306226656_untitled_session0156_c644f3db69f74052bef5b087ebe22e2e.jpg',NULL,1,1,'2025-06-30 17:57:06',NULL,NULL),(17,10,'/uploads/products/10/1751790964632_untitled_session0229_24aced36451748d0bfad88b68ff088d1.jpg',NULL,1,1,'2025-07-06 08:36:04',NULL,NULL),(20,1,'/uploads/products/1/1752175755059_untitled_capture0545_a475c7927af146009f6c6b4e2dc5eacf.jpg',NULL,1,1,'2025-07-10 12:29:15',NULL,NULL),(21,9,'/uploads/products/9/1752175811984_dsc04515_4dab82fb55504989b747f7afbe3dcbf6.webp',NULL,1,1,'2025-07-10 12:30:11',NULL,NULL),(22,12,'/uploads/products/12/1752175885486_hd_t6.jpg',NULL,1,1,'2025-07-10 12:31:25',NULL,NULL),(23,8,'/uploads/products/8/1752175913928_dsc04922_6cf0c5a347484e5c912d6c6eea10b3a5.jpg',NULL,1,1,'2025-07-10 12:31:53',NULL,NULL),(25,6,'/uploads/products/6/1752175949967_hades_0078_1_73938f7dbb4c4d1392f17ad8d8c85d06.jpg',NULL,1,1,'2025-07-10 12:32:29',NULL,NULL),(27,4,'/uploads/products/4/1752175983521_untitled_session0180_f974bb45041f460abe23315dfafbef97.jpg',NULL,1,1,'2025-07-10 12:33:03',NULL,NULL),(28,5,'/uploads/products/5/1752176007905_khan2_49fd68354ca04168bf8bd280c8ff4b17.jpg',NULL,1,1,'2025-07-10 12:33:27',NULL,NULL);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reviews` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `title` varchar(200) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `product_reviews_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `short_description` varchar(500) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `min_stock_level` int(11) DEFAULT 10,
  `max_stock_level` int(11) DEFAULT 1000,
  `category_id` bigint(20) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `material` varchar(100) DEFAULT NULL,
  `tags` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_code` (`product_code`),
  UNIQUE KEY `slug` (`slug`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'HADES001','HADES SPLICE POLO - BROWN','hades-splice-polo-brown','Premium polo shirt with unique splice design',NULL,521000.00,300000.00,NULL,50,10,1000,2,NULL,NULL,NULL,NULL,NULL,1,'2025-06-30 17:49:43','2025-07-05 10:15:50'),(2,'HADES002','HADES CHAMPION TANK TOP - BLACK','hades-champion-tank-top-black','Athletic tank top for champions',NULL,420000.00,200000.00,NULL,74,10,1000,2,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-16 08:23:21'),(3,'HADES003','HADES COZY STRIPE POLO SWEATER - RED','hades-cozy-stripe-polo-sweater-red','Warm and cozy striped sweater',NULL,1150000.00,600000.00,NULL,28,10,1000,2,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-05 10:15:50'),(4,'HADES004','HADES ROCK SOLID ZIP HOODIE','hades-rock-solid-zip-hoodie','Durable zip-up hoodie',NULL,850000.00,450000.00,NULL,35,10,1000,4,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-18 10:22:24'),(5,'HADES005','HADES DISTRICT 1 CAP','hades-district-1-cap','Stylish cap with District 1 design',NULL,320000.00,150000.00,NULL,100,10,1000,7,NULL,NULL,NULL,NULL,NULL,0,'2025-06-29 07:57:42','2025-07-18 01:54:55'),(6,'HADES006','HADES BLACK WAX BIKER JACKET','hades-black-wax-biker-jacket','Classic biker jacket with wax finish',NULL,1190000.00,700000.00,NULL,5,10,1000,4,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-18 10:22:24'),(8,'HADES008','HADES VOID DRIFTER PANTS','hades-void-drifter-pants','Comfortable drifting pants',NULL,790000.00,400000.00,NULL,38,10,1000,3,NULL,NULL,NULL,NULL,NULL,1,'2025-06-29 07:57:42','2025-07-18 10:22:24'),(9,'HADES009','HADES VOID DRIFTER ZIP HOODIE','hades-void-drifter-zip-hoodie','Matching zip hoodie for drifters',NULL,850000.00,450000.00,NULL,35,10,1000,7,'HADES','Black',NULL,'Cotton','hoodie,drifter,matching',1,'2025-06-29 07:57:42','2025-07-10 12:30:11'),(10,'HADES010','HADES CLASSIC KNICKERS - BLACK','hades-classic-knickers-black','Classic underwear in black',NULL,190000.00,80000.00,NULL,200,10,1000,7,NULL,NULL,NULL,NULL,NULL,0,'2025-06-29 07:57:42','2025-07-10 11:51:50'),(12,'HADES012','HADES Y-BACK SPORTS SHOCK - WHITE','hades-y-back-sports-bra-white','Supportive sports bra',NULL,290000.00,120000.00,NULL,88,10,1000,7,'HADES','White',NULL,'Polyester','sports-bra,supportive,active',1,'2025-06-29 07:57:42','2025-07-10 12:51:20'),(32,'ACC001','Urban Explorer Cap','urban-explorer-cap','A stylish cap for city adventures.',NULL,120000.00,80000.00,100000.00,50,10,1000,7,'HADES','Black','M','Cotton','cap,urban',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(33,'ACC002','Classic Leather Belt','classic-leather-belt','Premium leather belt for all outfits.',NULL,180000.00,120000.00,150000.00,40,10,1000,7,'HADES','Brown','L','Leather','belt,classic',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(34,'ACC003','Minimalist Silver Bracelet','minimalist-silver-bracelet','Elegant silver bracelet for daily wear.',NULL,220000.00,150000.00,180000.00,30,10,1000,7,'HADES','Silver','One Size','Metal','bracelet,silver',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(35,'ACC004','Winter Knit Scarf','winter-knit-scarf','Warm knit scarf for cold days.',NULL,90000.00,60000.00,80000.00,60,10,1000,7,'HADES','Gray','L','Wool','scarf,winter',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(36,'ACC005','Touchscreen Gloves','touchscreen-gloves','Gloves compatible with smartphones.',NULL,110000.00,70000.00,90000.00,70,10,1000,7,'HADES','Navy','M','Wool','gloves,tech',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(37,'ACC006','Retro Sunglasses','retro-sunglasses','Vintage style sunglasses.',NULL,250000.00,180000.00,220000.00,20,10,1000,7,'HADES','Black','One Size','Plastic','sunglasses,retro',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(38,'ACC007','Chrono Steel Watch','chrono-steel-watch','Stainless steel watch with chronograph.',NULL,500000.00,350000.00,400000.00,15,10,1000,7,'HADES','Silver','One Size','Metal','watch,chrono',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(39,'ACC008','Slim Card Wallet','slim-card-wallet','Minimalist wallet for cards and cash.',NULL,130000.00,90000.00,110000.00,80,10,1000,7,'HADES','Brown','One Size','Leather','wallet,slim',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(40,'ACC009','Key Organizer','key-organizer','Organize your keys in style.',NULL,60000.00,40000.00,50000.00,90,10,1000,7,'HADES','Silver','One Size','Metal','keychain,organizer',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(41,'ACC010','Bag Charm Pendant','bag-charm-pendant','Chic pendant for your bag.',NULL,70000.00,50000.00,60000.00,100,10,1000,7,'HADES','Pink','One Size','Plastic','charm,bag',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(42,'BAG001','City Backpack','city-backpack','Spacious backpack for daily use.',NULL,300000.00,200000.00,250000.00,40,10,1000,6,'HADES','Black','L','Nylon','backpack,city',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(43,'BAG002','Classic Messenger Bag','classic-messenger-bag','Messenger bag for work and travel.',NULL,350000.00,250000.00,300000.00,30,10,1000,6,'HADES','Brown','M','Leather','messenger,classic',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(44,'BAG003','Sport Duffel','sport-duffel','Duffel bag for gym and sports.',NULL,280000.00,180000.00,220000.00,25,10,1000,6,'HADES','Blue','XL','Polyester','duffel,sport',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(45,'BAG004','Travel Tote','travel-tote','Tote bag for travel essentials.',NULL,200000.00,140000.00,170000.00,50,10,1000,6,'HADES','Beige','L','Canvas','tote,travel',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(46,'BAG005','Mini Crossbody','mini-crossbody','Compact crossbody for quick trips.',NULL,150000.00,100000.00,120000.00,60,10,1000,6,'HADES','Red','S','Leather','crossbody,mini',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(47,'BAG006','Laptop Sleeve','laptop-sleeve','Protective sleeve for laptops.',NULL,120000.00,80000.00,100000.00,70,10,1000,6,'HADES','Gray','M','Neoprene','laptop,sleeve',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(48,'BAG007','Weekend Holdall','weekend-holdall','Holdall for weekend getaways.',NULL,400000.00,300000.00,350000.00,20,10,1000,6,'HADES','Navy','XL','Canvas','holdall,weekend',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(49,'BAG008','Drawstring Gym Bag','drawstring-gym-bag','Lightweight gym bag.',NULL,80000.00,50000.00,70000.00,80,10,1000,6,'HADES','Green','L','Polyester','gym,drawstring',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(50,'BAG009','Convertible Sling','convertible-sling','Sling bag with convertible straps.',NULL,170000.00,120000.00,140000.00,35,10,1000,6,'HADES','Black','M','Nylon','sling,convertible',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(51,'BAG010','Eco Shopper','eco-shopper','Reusable eco-friendly shopping bag.',NULL,60000.00,40000.00,50000.00,100,10,1000,6,'HADES','White','L','Cotton','shopper,eco',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(52,'BOT001','Slim Fit Jeans','slim-fit-jeans','Trendy slim fit jeans for all occasions.',NULL,250000.00,180000.00,220000.00,40,10,1000,3,'HADES','Denim','32','Denim','jeans,slim',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(53,'BOT002','Classic Chinos','classic-chinos','Versatile chinos for work or play.',NULL,200000.00,140000.00,170000.00,35,10,1000,3,'HADES','Khaki','34','Cotton','chinos,classic',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(54,'BOT003','Cargo Shorts','cargo-shorts','Comfortable cargo shorts with pockets.',NULL,150000.00,100000.00,120000.00,50,10,1000,3,'HADES','Olive','M','Cotton','shorts,cargo',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(55,'BOT004','Jogger Pants','jogger-pants','Casual jogger pants for active days.',NULL,180000.00,120000.00,150000.00,60,10,1000,3,'HADES','Gray','L','Polyester','joggers,casual',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(56,'BOT005','Denim Shorts','denim-shorts','Classic denim shorts for summer.',NULL,130000.00,90000.00,110000.00,70,10,1000,3,'HADES','Blue','M','Denim','shorts,denim',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(57,'BOT006','Tapered Trousers','tapered-trousers','Modern tapered trousers for style.',NULL,220000.00,150000.00,180000.00,30,10,1000,3,'HADES','Black','L','Cotton','trousers,tapered',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(58,'BOT007','Athletic Track Pants','athletic-track-pants','Track pants for workouts.',NULL,170000.00,120000.00,140000.00,80,10,1000,3,'HADES','Navy','XL','Polyester','track,athletic',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(59,'BOT008','Corduroy Pants','corduroy-pants','Soft corduroy pants for comfort.',NULL,210000.00,140000.00,170000.00,25,10,1000,3,'HADES','Brown','M','Corduroy','corduroy,soft',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(60,'BOT009','Linen Shorts','linen-shorts','Breathable linen shorts for hot days.',NULL,120000.00,80000.00,100000.00,90,10,1000,3,'HADES','White','L','Linen','shorts,linen',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(61,'BOT010','Plaid Skirt','plaid-skirt','Trendy plaid skirt for a bold look.',NULL,160000.00,110000.00,130000.00,55,10,1000,3,'HADES','Red','M','Cotton','skirt,plaid',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(62,'OUT001','Classic Denim Jacket','classic-denim-jacket','Timeless denim jacket for all seasons.',NULL,350000.00,250000.00,300000.00,30,10,1000,4,'HADES','Blue','L','Denim','jacket,denim',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(63,'OUT002','Hooded Windbreaker','hooded-windbreaker','Lightweight windbreaker with hood.',NULL,220000.00,150000.00,180000.00,40,10,1000,4,'HADES','Black','M','Polyester','windbreaker,hooded',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(64,'OUT003','Wool Overcoat','wool-overcoat','Warm wool overcoat for winter.',NULL,500000.00,350000.00,400000.00,20,10,1000,4,'HADES','Gray','XL','Wool','overcoat,wool',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(65,'OUT004','Bomber Jacket','bomber-jacket','Trendy bomber jacket for style.',NULL,280000.00,180000.00,220000.00,35,10,1000,4,'HADES','Green','L','Nylon','bomber,jacket',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(66,'OUT005','Puffer Vest','puffer-vest','Lightweight puffer vest for layering.',NULL,200000.00,140000.00,170000.00,50,10,1000,4,'HADES','Navy','M','Polyester','vest,puffer',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(67,'OUT006','Rain Parka','rain-parka','Waterproof parka for rainy days.',NULL,320000.00,220000.00,270000.00,25,10,1000,4,'HADES','Yellow','L','Polyester','parka,rain',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(68,'OUT007','Faux Leather Jacket','faux-leather-jacket','Edgy faux leather jacket.',NULL,400000.00,300000.00,350000.00,15,10,1000,4,'HADES','Black','M','Faux Leather','jacket,leather',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(69,'OUT008','Sherpa Lined Coat','sherpa-lined-coat','Cozy sherpa lined winter coat.',NULL,450000.00,320000.00,380000.00,18,10,1000,4,'HADES','Beige','XL','Cotton','coat,sherpa',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(70,'OUT009','Varsity Jacket','varsity-jacket','Classic varsity jacket for school spirit.',NULL,300000.00,200000.00,250000.00,22,10,1000,4,'HADES','Red','L','Wool','jacket,varsity',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(71,'OUT010','Trench Coat','trench-coat','Elegant trench coat for rainy days.',NULL,370000.00,250000.00,300000.00,28,10,1000,4,'HADES','Khaki','M','Cotton','coat,trench',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(72,'SAL001','Discounted Hoodie','discounted-hoodie','Hoodie at a special sale price.',NULL,150000.00,100000.00,120000.00,60,10,1000,8,'HADES','Gray','L','Cotton','hoodie,sale',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(73,'SAL002','Clearance T-Shirt','clearance-tshirt','T-shirt on clearance.',NULL,80000.00,50000.00,70000.00,80,10,1000,8,'HADES','White','M','Cotton','tshirt,clearance',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(74,'SAL003','Promo Joggers','promo-joggers','Joggers at a promo price.',NULL,120000.00,80000.00,100000.00,70,10,1000,8,'HADES','Black','L','Polyester','joggers,promo',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(75,'SAL004','Flash Sale Cap','flash-sale-cap','Cap on flash sale.',NULL,60000.00,40000.00,50000.00,90,10,1000,8,'HADES','Blue','One Size','Cotton','cap,flash',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(76,'SAL005','Outlet Shorts','outlet-shorts','Shorts from the outlet.',NULL,90000.00,60000.00,80000.00,100,10,1000,8,'HADES','Green','M','Cotton','shorts,outlet',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(77,'SAL006','Special Price Vest','special-price-vest','Vest at a special price.',NULL,110000.00,70000.00,90000.00,50,10,1000,8,'HADES','Yellow','L','Polyester','vest,special',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(78,'SAL007','Deal of the Day Bag','deal-of-the-day-bag','Bag on deal of the day.',NULL,130000.00,90000.00,110000.00,40,10,1000,8,'HADES','Brown','M','Leather','bag,deal',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(79,'SAL008','Limited Offer Watch','limited-offer-watch','Watch with limited offer.',NULL,200000.00,150000.00,180000.00,30,10,1000,8,'HADES','Silver','One Size','Metal','watch,limited',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(80,'SAL009','Bargain Sunglasses','bargain-sunglasses','Sunglasses at a bargain.',NULL,70000.00,50000.00,60000.00,120,10,1000,8,'HADES','Black','One Size','Plastic','sunglasses,bargain',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(81,'SAL010','Hot Deal Scarf','hot-deal-scarf','Scarf on hot deal.',NULL,100000.00,70000.00,90000.00,110,10,1000,8,'HADES','Red','L','Wool','scarf,hot',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(82,'TOP001','Classic White Tee','classic-white-tee','Essential white t-shirt for every wardrobe.',NULL,90000.00,60000.00,80000.00,100,10,1000,2,'HADES','White','M','Cotton','tshirt,classic',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(83,'TOP002','Striped Polo Shirt','striped-polo-shirt','Polo shirt with modern stripes.',NULL,120000.00,80000.00,100000.00,80,10,1000,2,'HADES','Blue','L','Cotton','polo,striped',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(84,'TOP003','Henley Long Sleeve','henley-long-sleeve','Long sleeve henley for cool days.',NULL,150000.00,100000.00,120000.00,70,10,1000,2,'HADES','Gray','XL','Cotton','henley,longsleeve',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(85,'TOP004','Graphic Print Tee','graphic-print-tee','T-shirt with bold graphic print.',NULL,110000.00,70000.00,90000.00,90,10,1000,2,'HADES','Black','M','Cotton','tshirt,graphic',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(86,'TOP005','V-Neck Basic','v-neck-basic','Basic v-neck t-shirt.',NULL,100000.00,70000.00,90000.00,60,10,1000,2,'HADES','Navy','L','Cotton','tshirt,vneck',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(87,'TOP006','Oversized Hoodie','oversized-hoodie','Trendy oversized hoodie.',NULL,200000.00,150000.00,180000.00,50,10,1000,2,'HADES','Beige','XL','Cotton','hoodie,oversized',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(88,'TOP007','Plaid Flannel Shirt','plaid-flannel-shirt','Classic plaid flannel shirt.',NULL,170000.00,120000.00,140000.00,40,10,1000,2,'HADES','Red','L','Flannel','shirt,plaid',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(89,'TOP008','Mock Neck Sweater','mock-neck-sweater','Warm mock neck sweater.',NULL,220000.00,150000.00,180000.00,30,10,1000,2,'HADES','Gray','M','Wool','sweater,mockneck',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(90,'TOP009','Short Sleeve Henley','short-sleeve-henley','Short sleeve henley for summer.',NULL,130000.00,90000.00,110000.00,80,10,1000,2,'HADES','Green','M','Cotton','henley,shortsleeve',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(91,'TOP010','Printed Tank Top','printed-tank-top','Tank top with unique print.',NULL,80000.00,50000.00,70000.00,120,10,1000,2,'HADES','Black','L','Cotton','tanktop,printed',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(92,'UND001','Classic Boxer Briefs','classic-boxer-briefs','Comfortable boxer briefs for daily wear.',NULL,60000.00,40000.00,50000.00,100,10,1000,5,'HADES','Black','M','Cotton','boxer,briefs',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(93,'UND002','Seamless Trunks','seamless-trunks','Seamless trunks for a smooth fit.',NULL,70000.00,50000.00,60000.00,90,10,1000,5,'HADES','Gray','L','Cotton','trunks,seamless',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(94,'UND003','Breathable Briefs','breathable-briefs','Breathable briefs for comfort.',NULL,80000.00,50000.00,70000.00,80,10,1000,5,'HADES','White','M','Cotton','briefs,breathable',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(95,'UND004','Athletic Boxer Shorts','athletic-boxer-shorts','Boxer shorts for athletes.',NULL,90000.00,60000.00,80000.00,70,10,1000,5,'HADES','Blue','L','Polyester','boxer,athletic',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(96,'UND005','Low Rise Briefs','low-rise-briefs','Low rise briefs for style.',NULL,75000.00,50000.00,60000.00,60,10,1000,5,'HADES','Red','M','Cotton','briefs,lowrise',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(97,'UND006','Cotton Trunks','cotton-trunks','Soft cotton trunks.',NULL,70000.00,50000.00,60000.00,50,10,1000,5,'HADES','Green','L','Cotton','trunks,cotton',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(98,'UND007','Patterned Boxer Briefs','patterned-boxer-briefs','Boxer briefs with patterns.',NULL,85000.00,60000.00,70000.00,40,10,1000,5,'HADES','Pattern','M','Cotton','boxer,patterned',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(99,'UND008','Thermal Underwear','thermal-underwear','Thermal underwear for winter.',NULL,120000.00,80000.00,100000.00,30,10,1000,5,'HADES','Gray','L','Wool','thermal,underwear',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(100,'UND009','Sport Briefs','sport-briefs','Briefs for sports activities.',NULL,90000.00,60000.00,80000.00,20,10,1000,5,'HADES','Navy','M','Polyester','briefs,sport',1,'2025-07-18 18:09:44','2025-07-18 18:09:44'),(101,'UND010','No Show Socks','no-show-socks','Invisible socks for shoes.',NULL,40000.00,20000.00,30000.00,110,10,1000,5,'HADES','White','One Size','Cotton','socks,noshow',1,'2025-07-18 18:09:44','2025-07-18 18:09:44');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(2,1),(2,4),(2,5),(2,7),(2,8),(2,9),(2,14),(3,1),(3,4),(3,5),(4,1),(4,2),(4,4),(4,5),(4,7),(4,8),(4,9),(4,14),(4,15),(4,17),(4,18);
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN','System Administrator','2025-06-29 07:57:42'),(2,'SALES','Sales Representative','2025-06-29 07:57:42'),(3,'CUSTOMER','Customer','2025-06-29 07:57:42'),(4,'MANAGER','Store Manager','2025-06-29 07:57:42'),(5,'USER','Default user role','2025-07-05 07:20:08');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (2,1),(3,5),(4,5),(5,3),(5,5),(6,3),(6,5);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `phone_verified` tinyint(1) NOT NULL DEFAULT 0,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'admin','admin@gmail.com','$2a$10$gXQIUSez4rK6w/5QF7z85eIV45.ug.Yxpw8iOOH9YkK3SKYt6xf2a','Admin','User',NULL,NULL,1,1,0,'2025-07-18 10:11:56','2025-06-29 11:12:37','2025-07-18 10:11:56'),(3,'bao','quocbao01651@gmail.com','$2a$10$1P019yJ.V/Yty229kQ9c6OL3GpnA2pOo5kqlk5dJa9BzDvW1zFhuu','Nguyễn','Bảo',NULL,NULL,1,0,0,'2025-07-05 01:46:37','2025-07-05 07:20:08','2025-07-05 07:20:08'),(4,'lam','quocbao0165sddsfd@gmail.com','$2a$10$0bhFWBJI4Y49YXcgcJyJIudecIAgFI8/1b.eb01plrQjSA0vnpL.S','lam','lam',NULL,NULL,1,0,0,NULL,'2025-07-10 11:43:16','2025-07-10 11:43:16'),(5,'nhi','nhi@gmail.com','$2a$10$9OyqbKJWX8t3FyGmk.vwd.IszGsl.u5D7fZlgqIUY8kwGKB7ihf.O','nhi','nguyen',NULL,NULL,1,0,0,'2025-07-16 08:17:23','2025-07-13 05:12:02','2025-07-16 08:17:23'),(6,'lam12','lam@gmail.com','$2a$10$3LM/C4U0YBZ4EZhozKGOKevhGCBmmz20ztdB18RQ9.BSj1EhJJY52','lam','lam',NULL,NULL,1,0,0,'2025-07-18 09:43:08','2025-07-18 09:42:44','2025-07-18 09:43:08');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_product` (`user_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-19  1:11:00
SET FOREIGN_KEY_CHECKS=0;
