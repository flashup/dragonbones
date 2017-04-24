﻿package dragonBones.textures
{
import openfl.display.BitmapData;

import dragonBones.core.BaseObject;
import dragonBones.core.DragonBones;

/**
 * @language zh_CN
 * 贴图集数据。
 * @version DragonBones 3.0
 */
public class TextureAtlasData extends BaseObject
{
	/**
	 * @language zh_CN
	 * 是否开启共享搜索。
	 * @see dragonBones.objects.ArmatureData
	 * @version DragonBones 4.5
	 */
	public var autoSearch:Bool;
	/**
	 * @language zh_CN
	 * 贴图集缩放系数。
	 * @version DragonBones 3.0
	 */
	public var scale:Float;
	/**
	 * @private
	 */
	public var width:Float;
	/**
	 * @private
	 */
	public var height:Float;
	/**
	 * @language zh_CN
	 * 贴图集名称。
	 * @version DragonBones 3.0
	 */
	public var name:String;
	/**
	 * @language zh_CN
	 * 贴图集图片路径。
	 * @version DragonBones 3.0
	 */
	public var imagePath:String;
	/**
	 * @private For AS.
	 */
	public var bitmapData:BitmapData;
	/**
	 * @private
	 */
	public inline var textures:Dynamic = {};
	/**
	 * @private
	 */
	public function TextureAtlasData(self:TextureAtlasData)
	{
		super(this);
		
		if (self != this)
		{
			throw new Error(DragonBones.ABSTRACT_CLASS_ERROR);
		}
	}
	/**
	 * @private
	 */
	override private function _onClear():Void
	{
		for (var k:String in textures)
		{
			(textures[k] as TextureData).returnToPool();
			delete textures[k];
		}
		
		autoSearch = false;
		scale = 1.0;
		width = 0.0;
		height = 0.0;
		//textures.clear();
		name = null;
		imagePath = null;
		
		if (bitmapData != null)
		{
			bitmapData.dispose();
			bitmapData = null;
		}
	}
	/**
	 * @private
	 */
	public function generateTexture():TextureData
	{
		throw new Error(DragonBones.ABSTRACT_METHOD_ERROR);
		return null;
	}
	/**
	 * @private
	 */
	public function addTexture(value:TextureData):Void
	{
		if (value != null && value.name != null && textures[value.name] == null)
		{
			textures[value.name] = value;
			value.parent = this;
		}
		else
		{
			throw new ArgumentError();
		}
	}
	/**
	 * @private
	 */
	public function getTexture(name:String):TextureData
	{
		return textures[name] as TextureData;
	}
	/**
	 * @private
	 */
	public function copyFrom(value: TextureAtlasData):Void 
	{
		autoSearch = value.autoSearch;
		scale = value.scale;
		width = value.width;
		height = value.height;
		name = value.name;
		imagePath = value.imagePath;
		
		for (var k:String in textures)
		{
			textures[k].returnToPool();
			delete textures[k];
		}
		
		for (k in value.textures) 
		{
			inline var texture:TextureData = generateTexture();
			texture.copyFrom(value.textures[k]);
			textures[k] = texture;
		}
	}
}
}